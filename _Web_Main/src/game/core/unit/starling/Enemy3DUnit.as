package game.core.unit.starling
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import game.app.managers.Depth3DMgr;
	import game.app.managers.TextureMgr;
	import game.base.models.ObjectModel;
	import game.core.controllers.dynamics.MonsterController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.models.dynamics.MonsterModel;
	import game.core.models.statics.MapModel;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.textures.TextureAtlas;
	
	public class Enemy3DUnit extends Map3DUnit
	{
		private var _model:MonsterModel;
		private var _controller:MonsterController;
		
		protected var m:MovieClip;
		protected var autoMoveSteps:uint;
		protected var currentMap:IMapView;
		protected var frameRate:uint = 8;
		protected var modelTypeID:uint;
		public var childIndex:uint;
		
		protected var atlas:TextureAtlas;
		
		private function get controller():MonsterController{
			return _controller;
		}
		override public function get model():*{
			return this._model as ObjectModel;
		}
		
		public function Enemy3DUnit()
		{
			super();
		}
		
		protected function onAttackHandler(e:ActionEvent):void{
			draw();
		}
		
		override public function init( data:Object = null):void{
			_model = new MonsterModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new MonsterController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_model.speed = 3;
			
			create( data[0] );
			
			_model.getPos( 1 );
		}
		private var q:Quad;
		
		public function create( data:Object ):void {
			
			var tf:TextFormat = new TextFormat("宋体", 14, 0xffffff);
			tf.align = TextAlign.CENTER;
			var testParam:uint = data as uint;
			q = new Quad(4,4,0x00ff00);
			this.addChild(q);
			modelTypeID = testParam - 1;
			m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m0" + model.dir), frameRate);
			addChild(m);
			Starling.juggler.add(m);
		}
		
		override public function onUpdateHandler(event:Event):void {
			super.onUpdateHandler(event);
			draw();
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
		
		public function draw():void{
			if(_model.currentDir != _model.dir){
				//trace("[PeopleView3D] dir" + _model.currentDir, _model.dir);
				_model.currentDir = _model.dir;
				removeChild(m);
				Starling.juggler.remove(m);
				if(_model.dir < 10){
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m0" + model.dir), frameRate);
				} else {
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m" + model.dir), frameRate);
				}
				m.x = -20;
				m.y = -80;
				//trace( "[MonsterView3D]当前 _model.dir: " + _model.dir );
				addChild(m);
				Starling.juggler.add(m);
			}
			if(this.parent){
				Depth3DMgr.swapDepth(this, model.posY);
			}
		}
	}
}