package game.core.map
{
	import game.core.events.ModelEvent;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.TileBlockModel;
	import game.core.statics.TileBlockController;
	import game.core.unit.MapUnit;
	
	import starling.display.Image;
	
	public class TileMapBlock extends MapUnit
	{
//		private var _model:TileBlockModel;
//		private var _controller:TileBlockController;
//		private var _image:Image;
//		
//		override public function get model():*{
//			return _model;
//		}
//		
//		public function TileMapBlock()
//		{
//		}
//		
//		override public function init( data:Object = null):void{
//			
//			_model = new TileBlockModel();
//			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
//			_controller = new TileBlockController();
//			_controller.init(_model);
//			_model.num = data[0];
//			
//			//原点放到菱形中间
//			_image = new Image( data[3] );
//			_image.x = - MapModel.TILE_BLOCK_WIDTH;
//			_image.y = - (MapModel.TILE_BLOCK_WIDTH>>1);
//			addChild(_image);
//			
//			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
//			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
//
//			super.x = _model.posX + MapModel.TILE_BLOCK_WIDTH;
//			super.y = _model.posY + (MapModel.TILE_BLOCK_WIDTH >> 1);
//		}
//		
//		public function clone( type:int, x:int, y:int ):TileMapBlock
//		{
//			var clone:TileMapBlock = new TileMapBlock();
//			clone.init( [ type, x, y, _image.texture ] ) 
//			return clone;
//		}
	}
}