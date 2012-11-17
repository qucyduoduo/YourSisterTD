package game.core.map
{
	import flash.display.Shape;
	
	import game.core.events.ModelEvent;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.Tile25BlockModel;
	import game.core.statics.Tile25BlockController;
	
	import starling.display.Image;

	public class Tile25MapBlock extends TileMapBlock
	{
		private var _model:Tile25BlockModel;
		private var _controller:Tile25BlockController;
		private var shape:Shape;
		private var _image:Image;
		
		override public function get model():*{
			return _model;
		}
		
		public function Tile25MapBlock()
		{
		}
		
		override public function init( data:Object = null):void{
			
			_model = new Tile25BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_controller = new Tile25BlockController();
			_controller.init(_model);
			_model.num = data[0];
			
			if(_model.num >= 1)
			{
				_image= new Image( data[3] );
				//原点放到菱形中间
				_image.y = - (MapModel.TILE_BLOCK_WIDTH>>1) - MapModel.TILE_BLOCK_WIDTH * data[0];
				//shape.alpha = 0.5;
			} else {
				//原点放到菱形中间
				_image = new Image( data[3] );
				_image.y = - (MapModel.TILE_BLOCK_WIDTH>>1);
			}
			_image.x = - MapModel.TILE_BLOCK_WIDTH;
			addChild(_image);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			
			super.x = _model.posX + MapModel.TILE_BLOCK_WIDTH;
			super.y = _model.posY + (MapModel.TILE_BLOCK_WIDTH >> 1);
		}
		
		override public function clone( type:int, x:int, y:int ):TileMapBlock
		{
			var clone:Tile25MapBlock = new Tile25MapBlock();
			clone.init( [ type, x, y, _image.texture ] );
			return clone;
		}
	}
}