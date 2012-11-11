package game.starling.view
{
	import flash.events.Event;
	
	import game.core.controllers.dynamics.PeopleController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IPeopleView;
	import game.app.managers.TextureMgr;
	import game.core.models.dynamics.PeopleModel;
	import game.core.models.statics.MapModel;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	/**
	 * 人物视图
	 * @author noah
	 */
	public class PeopleView3D extends DynamicObjectView3D implements IPeopleView
	{
		private var _model:PeopleModel;
		private var _controller:PeopleController;
		
		private function get controller():PeopleController{
			return _controller;
		}
		override public function get model():*{
			return this._model;
		}

		public function PeopleView3D(){
			
		}
		
		protected function onAttackHandler(e:ActionEvent):void{
			draw();
		}
		
		override public function init( data:Object = null):void{
			_model = new PeopleModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new PeopleController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			_model.speed = data[3];
			
			create( data[0] );
			
			_model.getPos( 1 );
		}
		
		protected function onDirChangeHandler(event:Event):void
		{
			// TODO Auto-generated method stub
		}
		
		override public function onUpdateHandler(event:Event):void {
			super.onUpdateHandler(event);
			draw();
		}
		
		override public function draw():void{
			
			if(_model.isGCD){
				if( isAniPlaying ){
					return;
				}
				isAniPlaying = true;
			} else {
				isAniPlaying = false;
			}
			
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
				//trace( "[PeopleView3D] 当前 _model.dir: " + _model.dir );
				addChild(m);
				Starling.juggler.add(m);
			}
			super.draw();
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