package game.starling.view
{
	import common.starling.views.BaseView3D;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.interfaces.IMapModel;
	import game.interfaces.IMapView;
	import game.interfaces.IObjectView;
	import game.managers.Depth3DMgr;
	import game.models.statics.TileMapModel;
	import game.untils.QuadNode;
	import game.untils.QuadTrees;
	
	import starling.display.Sprite;
	
	public class TileMapView3D extends BaseView3D implements IMapView
	{
		private var mapView:MapView3D;
		
		public function get model():IMapModel{
			return mapView.model;
		}
		public function set model(value:IMapModel):void{
			mapView.model = value;
		}
		public function get groundLevel():Sprite{
			return mapView.groundLevel;
		}
		public function get contentLevel():Sprite{
			return mapView.contentLevel;
		}
		public function get airLevel():Sprite{
			return mapView.airLevel;
		}
		public function get objTree():QuadTrees{
			return mapView.objTree;
		}
		
		public function set objTree(value:QuadTrees):void{
			mapView.objTree = value;
		}
		public function TileMapView3D(){
			super();
			mapView = new MapView3D();
			this.addChild( mapView );
		}
		override public function init( data:Object = null):void {
			model = new TileMapModel( data );
			objTree = new QuadTrees( 3 , new Rectangle(0,0, 512 ,512));
			var len:uint =  model.dataArr.length;
			for (var j:uint = 0;j<len;j++){
				for (var i:uint = 0;i<len;i++){
					drawBlock( model.dataArr[j][i],i,j );
				}
			}
			
			Depth3DMgr.swapDepthAll(contentLevel, "y");
		}
		protected function drawBlock( num:uint, _x:uint, _y:uint):void {
			var block:TileBlockView3D = new TileBlockView3D();
			block.init( [num, _x, _y]);
			if(num > 0){
				contentLevel.addChild( block );
			} else {
				groundLevel.addChild( block );
			}
			//这里要改成45度角仍旧使用模型的坐标系统
			objTree.insertObj(block);
		}
		/**
		 * 添加怪物
		 * @param monster
		 */		
		public function addMonster(monster:IObjectView):void{
			objTree.insertObj( monster );
			contentLevel.addChild( monster as BaseView3D );
		}
		/**
		 * 添加玩家
		 * @param p
		 */		
		public function addPlayer(p:IObjectView):void {
			objTree.insertObj( p );
			contentLevel.addChild( p as BaseView3D );
		}
		/**
		 * 获取指定的block
		 * @param args
		 */		
		public function getBlocks( pArr:Array):Array{
			
			var arr:Array = [];
			for each(var point:Point in pArr){
				var newNode:QuadNode = objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
				arr.push( newNode );
			}
			return arr;
		}
	}
}