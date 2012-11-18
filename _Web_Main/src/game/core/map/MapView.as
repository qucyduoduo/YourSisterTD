package game.core.map
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import game.base.units.GameUint;
	import game.core.interfaces.model.IMapModel;
	import game.core.interfaces.view.IMapView;
	import game.core.models.statics.MapModel;
	import game.untils.MgrObjects;
	import game.untils.QuadTrees;
	
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class MapView extends GameUint  implements IMapView, IAnimatable
	{
		/**
		 * 当没有贴图时使用的贴图 
		 */        
		protected static const NULL_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1,1,true,0));
		/**
		 * 四叉树 
		 */		
		protected var _objTree:QuadTrees;
		/**
		 * 地面层 
		 */		
		protected var _groundLevel:Image;
		/**
		 * 容器层 (排序)
		 */		
		protected var _contentLevel:Sprite;
		/**
		 * 天空层 
		 */		
		protected var _airLevel:Sprite;
		
		private var _renderTexutre:RenderTexture;

		protected var initParams:Object;
		
		public function get mapModel():IMapModel
		{
			return _model as IMapModel;
		}
		/**
		 * 构造函数
		 * 创建模型
		 * 创建四叉树
		 * @param data
		 */		
		public function MapView( mapData:Object )
		{
			super();
			initParams = {"mapData":mapData};
		}
		
		override public function init():void
		{
			_airLevel = new Sprite();
			_contentLevel = new Sprite();
			_groundLevel = new Image( NULL_TEXTURE );
			addChild(_groundLevel);
			addChild(_contentLevel);
			addChild(_airLevel);
			
			_model = new MapModel( initParams["mapData"] );
			objTree = new QuadTrees( 3 , new Rectangle(0,0, 960 , 640));
			drawMapBlocks();
		}
		
		override public function advanceTime(time:Number):void
		{
			//TODO: implement function
		}
		
		private function drawMapBlocks():void
		{
			var type:int;
			for (var j:uint = 0;j<MapModel.MAP_HEIGHT;j++)
			{
				for (var i:uint = 0;i<MapModel.MAP_WIDTH;i++)
				{
					type =  mapModel.dataList[ j* MapModel.MAP_WIDTH + i ];
					if( type )
					{
						drawContentBlock(  i, j );
					}
					else
					{
						drawGroundBlock( i, j );
					}
				}
			}
			drawMapGroundLevel();
		}
		
		private function drawContentBlock( x:uint, y:uint):void
		{
			var block:MapBlockView = MgrObjects.mapMgr.getMapBlock( 1, x, y );
			_contentLevel.addChild( block );
			objTree.insertObj(block);
		}
		
		private function drawGroundBlock( x:uint, y:uint ):void
		{
			if(!_renderTexutre)
			{
				_renderTexutre = new RenderTexture( 960, 640 );
			}
			var matrix:Matrix = new Matrix();
			matrix.translate( x * MapModel.BLOCK_WIDTH, y * MapModel.BLOCK_WIDTH);
			_renderTexutre.draw( MgrObjects.mapMgr.getMapBlock( 0, x, y ).image, matrix );
		}

		private function drawMapGroundLevel():void
		{
			_groundLevel.texture = _renderTexutre;
			_groundLevel.readjustSize();
		}
		
		public function get groundLevel():Image
		{
			return this._groundLevel;
		}
		public function get contentLevel():Sprite
		{
			return this._contentLevel;
		}
		public function get airLevel():Sprite
		{
			return this._airLevel;
		}
		public function get objTree():QuadTrees
		{
			return this._objTree;
		}
		public function set objTree(value:QuadTrees):void
		{
			this._objTree = value;
		}
//		/**
//		 * 添加怪物
//		 * @param monster
//		 */		
//		public function addMonster(monster:IObjectView):void
//		{
//			objTree.insertObj( monster );
//			this._contentLevel.addChild( monster as BaseView );
//		}
//		/**
//		 * 添加玩家
//		 * @param p
//		 */		
//		public function addPlayer(p:IObjectView):void 
//		{
//			objTree.insertObj( p );
//			this._contentLevel.addChild( p as BaseView );
//		}
//		/**
//		 * 获取指定的block
//		 * @param args
//		 */		
//		public function getBlocks( pArr:Array):Array
//		{
//			var arr:Array = [];
//			for each(var point:Point in pArr){
//				var newNode:QuadNode = this.objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
//				arr.push( newNode );
//			}
//			return arr;
//		}
	}
}