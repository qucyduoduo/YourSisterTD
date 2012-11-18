package game.core.map
{
	import game.base.units.StaticMapUnit;
	import game.core.events.ModelEvent;
	import game.core.models.statics.BlockModel;
	import game.core.models.statics.MapModel;
	import game.core.statics.BlockController;
	
	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * 2D地图格子视图
	 * @author noah
	 */	
	final public class MapBlockView extends StaticMapUnit
	{
		protected var _image:Image;
		
		public function get image():Image
		{
			return _image;
		}
		/**
		 * 构造函数
		 * 导入数据
		 * 绘制单元格
		 * @param num
		 * @param _x
		 * @param _y
		 */	
		public function MapBlockView( type:int, x:int, y:int, texture:Texture )
		{
			super( x, y );
			initParams["type"] = type;
			initParams["texture"] = texture;
			init();
		}
		
		override public function init():void
		{
			_model = new BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_controller = new BlockController();
			_controller.init(_model);
			
			_model.type = initParams["type"];
			
			_image = new Image( initParams["texture"] );
			addChild( _image );
			
			_model.x= initParams["x"] * MapModel.BLOCK_WIDTH;
			_model.y = initParams["y"] * MapModel.BLOCK_WIDTH;
			
			update();
		}
		
		public function clone( type:int, x:int, y:int):MapBlockView
		{
			var clone:MapBlockView = new MapBlockView( type, x, y, _image.texture );
			return clone;
		}
	}
}