package game.core.map
{
	import game.core.events.ModelEvent;
	import game.core.models.statics.BlockModel;
	import game.core.models.statics.MapModel;
	import game.core.statics.BlockController;
	import game.core.unit.starling.StaticMap3DUnit;
	
	import starling.display.Image;

	/**
	 * 2D地图格子视图
	 * @author noah
	 */	
	public class MapBlock extends StaticMap3DUnit
	{
		private var _model:BlockModel;
		private var _controller:BlockController;
		private var _image:Image;
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
		public function MapBlock()
		{
			super();
		}
		
		override public function init( data:Object = null):void 
		{
			_model = new BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_controller = new BlockController();
			_controller.init(_model);
			
			_model.num = data[0];
			
			_image = new Image( data[3] );
			
			addChild( _image );
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
		}
		
		public function clone( type:int, x:int, y:int):MapBlock
		{
			var clone:MapBlock = new MapBlock();
			clone.init( [ type, x, y, _image.texture ] ) 
			return clone;
		}
	}
}