package game.starling.view
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import game.core.statics.BlockController;
	import game.core.events.ModelEvent;
	import game.core.models.statics.BlockModel;
	import game.core.models.statics.MapModel;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * 2D地图格子视图
	 * @author noah
	 */	
	public class BlockView3D extends StaticObjectView3D
	{
		private var _model:BlockModel;
		private var _controller:BlockController;
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
		public function BlockView3D() {
		
		}
		override public function init( data:Object = null):void {
			
			_model = new BlockModel();
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_controller = new BlockController();
			_controller.init(_model);
			_model.num = data[0];

			var s:Sprite = new Sprite();
			s.graphics.beginFill( _model.num > 0?0x000000:0xffffff );
			s.graphics.lineStyle(1,0xcccccc)
			s.graphics.lineTo( 0 , 0  );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH, 0 );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH  , MapModel.BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.BLOCK_WIDTH);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.BLOCK_WIDTH + 1, MapModel.BLOCK_WIDTH + 1, true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			var mImage:Image = new Image(mTexture);
			addChild(mImage);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
		}
	}
}