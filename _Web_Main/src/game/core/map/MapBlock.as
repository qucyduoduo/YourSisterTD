package game.core.map
{
	import game.core.events.ModelEvent;
	import game.core.models.statics.BlockModel;
	import game.core.models.statics.MapModel;
	import game.core.statics.BlockController;
	import game.core.unit.StaticMapUnit;
	
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * 2D地图格子视图
	 * @author noah
	 */	
	public class MapBlock extends StaticMapUnit
	{
		private var _model:BlockModel;
		private var _controller:BlockController;
		private var _image:Image;
		
		public function get image():Image
		{
			return _image;
		}
		/**
		 * 
		 * @return 
		 */		
		override public function get model():* {
			return _model;
		}
		/**
		 * 构造函数
		 * 导入数据
		 * 绘制单元格
		 * @param num
		 * @param _x
		 * @param _y
		 */	
		public function MapBlock( type:int, x:int, y:int, texture:Texture )
		{
			super();
			_model = new BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_controller = new BlockController();
			_controller.init(_model);
			
			_model.type = type;
			
			_image = new Image( texture );
			addChild( _image );
			
			_model.x= x * MapModel.BLOCK_WIDTH;
			_model.y = y * MapModel.BLOCK_WIDTH;
			
			this.x = _model.x;
			this.y = _model.y;
		}
		
		public function clone( type:int, x:int, y:int):MapBlock
		{
			var clone:MapBlock = new MapBlock( type, x, y, _image.texture );
			return clone;
		}
	}
}