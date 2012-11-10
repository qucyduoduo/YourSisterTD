package game.starling.view
{
	import common.starling.managers.Display3DMgr;
	import common.utils.MgrObjects;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.rpg.controllers.SkillBallController;
	import game.events.ActionEvent;
	import game.events.ModelEvent;
	import game.events.SkillEvent;
	import game.interfaces.IMapView;
	import org.rpg.managers.Depth3DMgr;
	import org.rpg.managers.DepthMgr;
	import org.rpg.models.MapModel;
	import org.rpg.models.ObjectModel;
	import org.rpg.models.SkillBallModel;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class SkillBallView3D extends ObjectView3D
	{
		private var _model:SkillBallModel;
		private var _controller:SkillBallController;
		
		public var isAniPlaying:Boolean;
		
		protected var s:Sprite;
		protected var autoMoveSteps:uint;
		protected var currentMap:IMapView;
		
		public var childIndex:uint;
		public var hasRemoved:Boolean;
		
		private function get controller():SkillBallController{
			return _controller;
		}
		override public function get model():*{
			return this._model;
		}
		
		public function SkillBallView3D()
		{
		}
		
		override public function init( data:Object = null):void{
			super.init();
			_model = new SkillBallModel;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_model.addEventListener( SkillEvent.SKILL_REMOVE, onRemoveSkillHandler);
			_controller = new SkillBallController;
			_controller.init(_model);
			
			_model.modX = data[0];
			_model.modY = data[1];
			_model.speed = data[2];
			
			create( data );
			
			_model.getPos( 1 );
		}
		/**
		 * 
		 * @param event
		 */		
		protected function onRemoveSkillHandler(event:Event):void
		{
			_model.removeEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_model.removeEventListener( SkillEvent.SKILL_REMOVE, onRemoveSkillHandler);
			MgrObjects.display3DMgr.removeForParent( mImage );
			hasRemoved = true;
		}
		
		protected function onDirChangeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected var mImage:Image;
		
		public function create( data:Object ):void {
			
			var testParam:uint = data as uint;
			if( testParam == 1){
			} else if( testParam == 2) {
			} else if( testParam == 3){
			}
			s = new Sprite();
			s.graphics.beginFill(0xff0000);
			s.graphics.drawCircle( 2, 2, 4);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( 2 , 2 , true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			mImage = new Image(mTexture);
			//原点放到菱形中间
			mImage.x = 0;
			mImage.y = 0;
			addChild(mImage);
			
		}
		
		override public function onUpdateHandler(event:Event):void {
			super.onUpdateHandler(event);
			draw();
		}
		
		public function draw():void{
			if(this.parent){
				Depth3DMgr.swapDepth(this, model.posY);
			}
		}
		/**
		 * 
		 * @param e
		 */		
		public function onInputHandler( map:IMapView ):void {
			
			if(currentMap != map){
				currentMap = map;
			}
			controller.onInputHandler( map );
		}
	}
}