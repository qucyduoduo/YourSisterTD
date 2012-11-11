package game.starling.view
{
	import common.base.views.starling.BaseView;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IObjectView;
	import game.app.managers.Depth3DMgr;
	import game.core.models.statics.MapModel;
	import game.untils.QuadNode;
	import game.untils.QuadTrees;
	
	import starling.display.Sprite;

	/**
	 * 2D地图视图
	 * @author noah
	 */	
	public class MapView3D extends BaseView implements IMapView
	{
		protected var _objTree:QuadTrees;
		/**
		 * 地面层 
		 */		
		protected var _groundLevel:Sprite;
		/**
		 * 容器层 (排序)
		 */		
		protected var _contentLevel:Sprite;
		/**
		 * 天空层 
		 */		
		protected var _airLevel:Sprite;
		
		protected var _model:IMapModel;
		
		public function get groundLevel():Sprite{
			return this._groundLevel;
		}
		public function get contentLevel():Sprite{
			return this._contentLevel;
		}
		public function get airLevel():Sprite{
			return this._airLevel;
		}
		
		public function get model():IMapModel{
			return _model;
		}
		public function set model(value:IMapModel):void{
			this._model = value;
		}
		
		public function get objTree():QuadTrees{
			return this._objTree;
		}
		
		public function set objTree(value:QuadTrees):void{
			this._objTree = value;
		}
		/**
		 * 构造函数
		 * 创建模型
		 * 创建四叉树
		 * @param data
		 */		
		public function MapView3D() {
			super();
			_airLevel = new Sprite();
			_contentLevel = new Sprite();
			_groundLevel = new Sprite();
			this.addChild(_groundLevel);
			this.addChild(_contentLevel);
			this.addChild(_airLevel);
		}
		override public function init( data:Object = null):void {
			
			_model = new MapModel( data );
			objTree = new QuadTrees( 3 , new Rectangle(0,0, 512 , 512));
			var len:uint =  _model.dataArr.length;
			for (var j:uint = 0;j<len;j++){
				for (var i:uint = 0;i<len;i++){
					drawBlock( _model.dataArr[j][i],i,j );
				}
			}
			Depth3DMgr.swapDepthAll(this._contentLevel, "y");
		}
		/**
		 * 绘制单元格
		 * @param num
		 * @param _x
		 * @param _y
		 */		
		protected function drawBlock( num:uint, _x:uint, _y:uint):void {
			var block:BlockView3D = new BlockView3D();
			block.init([ num, _x, _y]);
			if(num > 0){
				_contentLevel.addChild( block );
			} else {
				_groundLevel.addChild( block );
			}
			objTree.insertObj(block);
		}
		/**
		 * 添加怪物
		 * @param monster
		 */		
		public function addMonster(monster:IObjectView):void{
			objTree.insertObj( monster );
			this._contentLevel.addChild( monster as BaseView );
		}
		/**
		 * 添加玩家
		 * @param p
		 */		
		public function addPlayer(p:IObjectView):void {
			objTree.insertObj( p );
			this._contentLevel.addChild( p as BaseView );
		}
		/**
		 * 获取指定的block
		 * @param args
		 */		
		public function getBlocks( pArr:Array):Array{
			
			var arr:Array = [];
			for each(var point:Point in pArr){
				var newNode:QuadNode = this.objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
				arr.push( newNode );
			}
			return arr;
		}
	}
}