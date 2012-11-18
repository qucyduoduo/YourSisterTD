package game.core.managers
{
	import common.base.interfaces.IMgr;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	
	import game.core.map.MapBlockView;
	import game.core.models.statics.MapModel;
	import game.untils.MapLoader;
	
	import starling.textures.Texture;

	/**
	 * 地图管理器 
	 * @author noah
	 * 
	 */	
	public class MapMgr extends EventDispatcher implements IMgr
	{
		private var _mapBlockList:Vector.<MapBlockView>;
//		private var _tileMapBlockList:Vector.<TileMapBlock>;;
		
		public function MapMgr()
		{
			super();
			_mapBlockList = new Vector.<MapBlockView>(2);
//			_tileMapBlockList = new Vector.<TileMapBlock>(2);
		}
		
		public function loadMap( func:Function ):void
		{
			MapLoader.load( func );
		}
		
		public function getMapBlock( type:int, x:int, y:int ):MapBlockView
		{
			if( _mapBlockList[type] == null )
			{
				makeMapBlock( type, x, y );
			}
			return _mapBlockList[type].clone( type, x, y );
		}
//		
//		public function getTileMapBlock( type:int, x:int, y:int ):TileMapBlock
//		{
//			if( _tileMapBlockList[type] == null )
//			{
//				makeTileMapBlock( type, x, y );
//			}
//			return _tileMapBlockList[type].clone( type, x, y );	
//		}

		/**
		 * 创建地图单元贴图，根据type选择不同贴图
		 * @param type
		 * @param x
		 * @param y
		 */		
		private function makeMapBlock( type:int, x:int, y:int ):void
		{
			var s:Shape = new Shape();
			s.graphics.beginFill( type > 0?0x000000:0xffffff );
			s.graphics.lineStyle(1,0xcccccc)
			s.graphics.lineTo( 0 , 0  );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH, 0 );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH  , MapModel.BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.BLOCK_WIDTH);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.BLOCK_WIDTH + 1, MapModel.BLOCK_WIDTH + 1, true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			
			_mapBlockList[type] = new MapBlockView( type, x, y, mTexture);
		}
		
//		private function makeTileMapBlock(type:int, x:int, y:int):void
//		{
//			_tileMapBlockList[type] = new TileMapBlock();
//			
//			var s:Shape = new Shape();
//			s.graphics.beginFill( type > 0?0x000000:0xffffff );
//			s.graphics.lineStyle(1,0xcccccc)
//			s.graphics.moveTo( MapModel.TILE_BLOCK_WIDTH , 0  );
//			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH * 2  , MapModel.TILE_BLOCK_WIDTH >> 1 );
//			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH  , MapModel.TILE_BLOCK_WIDTH );
//			s.graphics.lineTo( 0 , MapModel.TILE_BLOCK_WIDTH >> 1);
//			s.graphics.endFill();
//			
//			var bd:BitmapData = new BitmapData( MapModel.TILE_BLOCK_WIDTH * 2 , MapModel.TILE_BLOCK_WIDTH , true, 0x00000000);
//			bd.draw( s );
//			
//			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
//			
//			_tileMapBlockList[type].init( [type, x, y, mTexture] );
//		}
		
		public function dispose():void
		{
			
		}
		
		public function get isDisposed():Boolean
		{
			return false;
		}
	}
}