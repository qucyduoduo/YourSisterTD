package game.core.map
{
	import common.base.views.starling.BaseView;
	import common.utils.QuadNode;
	import common.utils.QuadTrees;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.base.views.GameUint;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IObjectView;
	import game.core.models.statics.MapModel;
	import game.untils.MgrObjects;
	
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	public class Map extends GameUint  implements IMapView, IAnimatable
	{
		/**
		 * 当没有贴图时使用的贴图 
		 */        
		protected static const NULL_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1,1,true,0));
		
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
		
		protected var _model:IMapModel;
		
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
		
		public function get model():IMapModel
		{
			return _model;
		}
		public function set model(value:IMapModel):void
		{
			this._model = value;
		}
		
		public function get objTree():QuadTrees
		{
			return this._objTree;
		}
		
		public function set objTree(value:QuadTrees):void
		{
			this._objTree = value;
		}
		
		/**
		 * 构造函数
		 * 创建模型
		 * 创建四叉树
		 * @param data
		 */		
		public function Map()
		{
			super();
			_airLevel = new Sprite();
			_contentLevel = new Sprite();
			_groundLevel = new Image( NULL_TEXTURE );
			addChild(_groundLevel);
			addChild(_contentLevel);
			addChild(_airLevel);
		}
		
		public function advanceTime(time:Number):void
		{
			//TODO: implement function
		}
		
		override public function init( data:Object = null):void 
		{
			_model = new MapModel( data );
			objTree = new QuadTrees( 3 , new Rectangle(0,0, 960 , 640));
			drawMapBlocks();
		}
		
		private function drawMapBlocks():void
		{
			var type:int;
			for (var j:uint = 0;j<MapModel.MAP_HEIGHT;j++)
			{
				for (var i:uint = 0;i<MapModel.MAP_WIDTH;i++)
				{
					type =  _model.dataList[ j* MapModel.MAP_WIDTH + i ];
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
			var block:MapBlock = MgrObjects.mapMgr.getMapBlock( 1, x, y );
			_contentLevel.addChild( block );
			objTree.insertObj(block);
		}
		
		private var _renderTexutre:RenderTexture;
		
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
		/**
		 * 添加怪物
		 * @param monster
		 */		
		public function addMonster(monster:IObjectView):void
		{
			objTree.insertObj( monster );
			this._contentLevel.addChild( monster as BaseView );
		}
		/**
		 * 添加玩家
		 * @param p
		 */		
		public function addPlayer(p:IObjectView):void 
		{
			objTree.insertObj( p );
			this._contentLevel.addChild( p as BaseView );
		}
		/**
		 * 获取指定的block
		 * @param args
		 */		
		public function getBlocks( pArr:Array):Array
		{
			var arr:Array = [];
			for each(var point:Point in pArr){
				var newNode:QuadNode = this.objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
				arr.push( newNode );
			}
			return arr;
		}
	}
}