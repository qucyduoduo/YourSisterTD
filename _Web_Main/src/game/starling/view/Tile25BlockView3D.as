package game.starling.view
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import game.core.statics.Tile25BlockController;
	import game.core.events.ModelEvent;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.Tile25BlockModel;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class Tile25BlockView3D extends TileBlockView3D
	{
		private var _model:Tile25BlockModel;
		private var _controller:Tile25BlockController;
		private var shape:Shape;
		
		override public function get model():*{
			return _model;
		}
		
		public function Tile25BlockView3D()
		{
		}
		
		override public function init( data:Object = null):void{
			
			_model = new Tile25BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_controller = new Tile25BlockController();
			_controller.init(_model);
			_model.num = data[0];
			
			if(_model.num >= 1){
				draw25TileBlock( _model.num);
				//shape.alpha = 0.5;
			} else {
				drawTileBlock( _model.num);
			}
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			
			super.x = _model.posX + MapModel.TILE_BLOCK_WIDTH;
			super.y = _model.posY + (MapModel.TILE_BLOCK_WIDTH >> 1);
		}
		
		private function draw25TileBlock( num:uint):void{

			var boxH:uint = MapModel.TILE_BLOCK_WIDTH * num;
			var s:Sprite = new Sprite();
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
			var mImage:Image = new Image(mTexture);
			//原点放到菱形中间
			mImage.x = - MapModel.TILE_BLOCK_WIDTH;
			mImage.y = - (MapModel.TILE_BLOCK_WIDTH>>1) - boxH;
			addChild(mImage);
		}
	}
}