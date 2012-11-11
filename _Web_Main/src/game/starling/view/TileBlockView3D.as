package game.starling.view
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import game.core.statics.TileBlockController;
	import game.core.events.ModelEvent;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.TileBlockModel;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class TileBlockView3D extends ObjectView
	{
		private var _model:TileBlockModel;
		private var _controller:TileBlockController;
		
		override public function get model():*{
			return _model;
		}
		
		public function TileBlockView3D()
		{
		}
		
		override public function init( data:Object = null):void{
			
			_model = new TileBlockModel();
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_controller = new TileBlockController();
			_controller.init(_model);
			_model.num = data[0];
			drawTileBlock( _model.num);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;

			super.x = _model.posX + MapModel.TILE_BLOCK_WIDTH;
			super.y = _model.posY + (MapModel.TILE_BLOCK_WIDTH >> 1);
		}
		
		protected function drawTileBlock(num:uint):void{
			
			var s:Sprite = new Sprite();
			s.graphics.beginFill( num > 0?0x000000:0xffffff );
			s.graphics.lineStyle(1,0xcccccc)
			s.graphics.moveTo( MapModel.TILE_BLOCK_WIDTH , 0  );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH * 2  , MapModel.TILE_BLOCK_WIDTH >> 1 );
			s.graphics.lineTo( MapModel.TILE_BLOCK_WIDTH  , MapModel.TILE_BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.TILE_BLOCK_WIDTH >> 1);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.TILE_BLOCK_WIDTH * 2 , MapModel.TILE_BLOCK_WIDTH , true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			var mImage:Image = new Image(mTexture);
			//原点放到菱形中间
			mImage.x = - MapModel.TILE_BLOCK_WIDTH;
			mImage.y = - (MapModel.TILE_BLOCK_WIDTH>>1);
			addChild(mImage);
		}
	}
}