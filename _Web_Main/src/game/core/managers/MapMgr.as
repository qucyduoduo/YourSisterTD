package game.core.managers
{
	import common.base.interfaces.IMgr;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	
	import game.core.map.MapBlock;
	import game.core.map.Tile25MapBlock;
	import game.core.map.TileMapBlock;
	import game.core.models.statics.MapModel;
	
	import starling.textures.Texture;

	/**
	 * 地图管理器 
	 * @author noah
	 * 
	 */	
	public class MapMgr extends EventDispatcher implements IMgr
	{
		private var _mapBlockList:Vector.<MapBlock>;
		private var _tileMapBlockList:Vector.<TileMapBlock>;;
		private var _tile25MapBlockList:Vector.<Tile25MapBlock>;;
		
		public function MapMgr()
		{
			super();
			_mapBlockList = new Vector.<MapBlock>(2);
			_tileMapBlockList = new Vector.<TileMapBlock>(2);
			_tile25MapBlockList = new Vector.<Tile25MapBlock>(2);
		}
		
		public function getMapBlock( type:int, x:int, y:int ):MapBlock
		{
			if( _mapBlockList[type] == null )
			{
				makeMapBlock( type, x, y );
			}
			return _mapBlockList[type].clone( type, x, y );
		}
		
		public function getTileMapBlock( type:int, x:int, y:int ):TileMapBlock
		{
			if( _tileMapBlockList[type] == null )
			{
				makeTileMapBlock( type, x, y );
			}
			return _tileMapBlockList[type].clone( type, x, y );	
		}

		public function getTile25MapBlock( type:int, x:int, y:int ):TileMapBlock
		{
			if( _tile25MapBlockList[type] == null )
			{
				if(type)
				{
					makeTile25MapBlock( type, x, y );
				}
				else
				{
					makeTileMapBlock( type, x, y );
				}
			}
			if(type)
			{
				return _tile25MapBlockList[type].clone( type, x, y ) as TileMapBlock;	
			}
			else
			{
				return _tileMapBlockList[type].clone( type, x, y );
			}
		}
		
		/**
		 * 创建地图单元贴图，根据type选择不同贴图
		 * @param type
		 * @param x
		 * @param y
		 */		
		private function makeMapBlock( type:int, x:int, y:int ):void
		{
			_mapBlockList[type] = new MapBlock();
			
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
			
			_mapBlockList[type].init( [type, x, y, mTexture] );
		}
		
		private function makeTileMapBlock(type:int, x:int, y:int):void
		{
			_tileMapBlockList[type] = new TileMapBlock();
			
			var s:Shape = new Shape();
			s.graphics.beginFill( type > 0?0x000000:0xffffff );
			s.graphics.lineStyle(1,0xcccccc)
			s.graphics.moveTo( MapModel.TILE_BLOCK_WIDTH , 0  );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH * 2  , MapModel.TILE_BLOCK_WIDTH >> 1 );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH  , MapModel.TILE_BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.TILE_BLOCK_WIDTH >> 1);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.TILE_BLOCK_WIDTH * 2 , MapModel.TILE_BLOCK_WIDTH , true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			
			_tileMapBlockList[type].init( [type, x, y, mTexture] );
		}
		
		private function makeTile25MapBlock(type:int, x:int, y:int):void
		{
			_tile25MapBlockList[type] = new Tile25MapBlock();
			
			var boxH:uint = MapModel.TILE_BLOCK_WIDTH * type;
			var s:Shape = new Shape();
			s.graphics.beginFill( 0x333333 );
			s.graphics.lineStyle(1,0xcccccc);
			s.graphics.moveTo( MapModel.TILE_BLOCK_WIDTH * 2, MapModel.TILE_BLOCK_WIDTH>>1);
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH * 2, (MapModel.TILE_BLOCK_WIDTH>>1) + boxH);
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH, MapModel.TILE_BLOCK_WIDTH + boxH);
			s.graphics.lineTo( 0 , (MapModel.TILE_BLOCK_WIDTH>>1) + boxH);
			s.graphics.lineTo( 0 , MapModel.TILE_BLOCK_WIDTH>>1);
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH, MapModel.TILE_BLOCK_WIDTH);
			s.graphics.endFill();
			
			s.graphics.beginFill( 0x999999);
			s.graphics.lineStyle(1,0xcccccc)
			s.graphics.moveTo( MapModel.TILE_BLOCK_WIDTH , 0  );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH * 2  , MapModel.TILE_BLOCK_WIDTH >> 1 );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH  , MapModel.TILE_BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.TILE_BLOCK_WIDTH >> 1);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.TILE_BLOCK_WIDTH * 2 , MapModel.TILE_BLOCK_WIDTH + boxH , true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			
			_tile25MapBlockList[type].init( [type, x, y, mTexture] );
		}	
		
		public function dispose():void
		{
			
		}
		
		public function get isDisposed():Boolean
		{
			return false;
		}
	}
}