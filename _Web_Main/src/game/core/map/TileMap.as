package game.core.map
{
	import common.base.views.starling.BaseView;
	import common.utils.QuadNode;
	import common.utils.QuadTrees;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IObjectView;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.TileMapModel;
	import game.untils.MgrObjects;
	
	import starling.display.Sprite;
	
	public class TileMap extends BaseView //implements IMapView
	{
//		private var mapView:Map;
//		
//		public function get model():IMapModel{
//			return mapView.model;
//		}
//		public function set model(value:IMapModel):void{
//			mapView.model = value;
//		}
//		public function get groundLevel():Sprite{
//			return mapView.groundLevel;
//		}
//		public function get contentLevel():Sprite{
//			return mapView.contentLevel;
//		}
//		public function get airLevel():Sprite{
//			return mapView.airLevel;
//		}
//		public function get objTree():QuadTrees{
//			return mapView.objTree;
//		}
//		
//		public function set objTree(value:QuadTrees):void{
//			mapView.objTree = value;
//		}
//		public function TileMap(){
//			super();
//			mapView = new Map();
//			this.addChild( mapView );
//		}
//		override public function init( data:Object = null):void 
//		{
//			model = new TileMapModel( data );
//			objTree = new QuadTrees( 3 , new Rectangle(0,0, 512 ,512));
//			for (var j:uint = 0;j<MapModel.MAP_HEIGHT;j++)
//			{
//				for (var i:uint = 0;i<MapModel.MAP_WIDTH;i++)
//				{
//					drawBlock( model.dataArr[ j *MapModel.MAP_WIDTH + i ],i,j );
//				}
//			}
//		}
//		protected function drawBlock( type:uint, x:uint, y:uint):void 
//		{
//			var block:TileMapBlock = MgrObjects.mapMgr.getTileMapBlock( type, x, y );
//			if(type > 0)
//			{
//				contentLevel.addChild( block );
//			} else {
//				groundLevel.addChild( block );
//			}
//			//这里要改成45度角仍旧使用模型的坐标系统
//			objTree.insertObj(block);
//		}
//		/**
//		 * 添加怪物
//		 * @param monster
//		 */		
//		public function addMonster(monster:IObjectView):void{
//			objTree.insertObj( monster );
//			contentLevel.addChild( monster as BaseView );
//		}
//		/**
//		 * 添加玩家
//		 * @param p
//		 */		
//		public function addPlayer(p:IObjectView):void {
//			objTree.insertObj( p );
//			contentLevel.addChild( p as BaseView );
//		}
//		/**
//		 * 获取指定的block
//		 * @param args
//		 */		
//		public function getBlocks( pArr:Array):Array{
//			
//			var arr:Array = [];
//			for each(var point:Point in pArr){
//				var newNode:QuadNode = objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
//				arr.push( newNode );
//			}
//			return arr;
//		}
	}
}