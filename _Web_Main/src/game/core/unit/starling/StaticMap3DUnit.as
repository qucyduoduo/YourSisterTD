package game.core.unit.starling
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import game.app.managers.DepthMgr;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.models.statics.MapModel;
	import game.core.models.statics.StaticObjectModel;
	import game.core.statics.StaticObjectController;
	
	import starling.display.MovieClip;
	import starling.display.Quad;
	
	/**
	 * 静态物体视图
	 * @author noah
	 */	
	public class StaticMap3DUnit extends Map3DUnit
	{
		private var _model:StaticObjectModel;
		private var _controller:StaticObjectController;
		private var q:Quad;
		
		public var isAniPlaying:Boolean;
		public var childIndex:uint;
		
		protected var autoMoveSteps:uint;
		protected var currentMap:IMapView;
		protected var frameRate:uint = 8;
		protected var modelTypeID:uint;
		
		private function get controller():StaticObjectController
		{
			return _controller;
		}
		override public function get model():*{
			return this._model;
		}
		
		public function StaticMap3DUnit()
		{
			super();
		}
		
		override public function init( data:Object = null):void{
			super.init();
			_model = new StaticObjectModel();
			_controller = new StaticObjectController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			//_model.speed = data[3];
			
			create( data[0] );
			
			_model.getPos( 1 );
		}
		override public function onUpdateHandler(event:Event):void {
			super.onUpdateHandler(event);
			draw();
		}
		
		public function draw():void{
			if(this.parent){
				DepthMgr.swapDepth(this, model.posY);
			}
		}
		
		public function create( data:Object ):void {
			
			var tf:TextFormat = new TextFormat("宋体", 14, 0xffffff);
			tf.align = TextAlign.CENTER;
			var testParam:uint = data as uint;
			q = new Quad(4,4,0xff0000);
			this.addChild(q);
			modelTypeID = testParam - 1;
		}
	}
}