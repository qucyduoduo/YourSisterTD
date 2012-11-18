package game.core.unit
{
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import game.base.models.ObjectModel;
	import game.core.controllers.dynamics.MonsterController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.models.dynamics.MonsterModel;
	import game.core.models.statics.MapModel;
	
	import starling.display.Quad;
	import starling.textures.TextureAtlas;
	
	public class EnemyUnit extends MapUnit
	{
		private var _model:MonsterModel;
		private var _controller:MonsterController;
		
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
		
		public function EnemyUnit()
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
			
			_model.x = data[1] * MapModel.BLOCK_WIDTH;
			_model.y = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
//			_model.speed = 3;
			
			create( data[0] );
		}
		private var q:Quad;
		
		public function create( data:Object ):void {
			
			var tf:TextFormat = new TextFormat("宋体", 14, 0xffffff);
			tf.align = TextAlign.CENTER;
			var testParam:uint = data as uint;
			q = new Quad(3,3,0x00ff00);
			q.x = -1;
			q.y = -1;
			this.addChild(q);
			modelTypeID = testParam - 1;
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
//			if(_model.currentDir != _model.dir){
//				//trace("[PeopleView3D] dir" + _model.currentDir, _model.dir);
//				_model.currentDir = _model.dir;
//			}
		}
	}
}