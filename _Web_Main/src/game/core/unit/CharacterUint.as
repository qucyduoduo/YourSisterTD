package  game.core.unit
{
	import flash.events.Event;
	
	import game.base.units.DynamicMapUnit;
	import game.core.controllers.dynamics.CharacterController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.model.ICharacterModel;
	import game.core.interfaces.view.ICharacterView;
	import game.core.models.dynamics.CharacterModel;
	import game.core.models.statics.MapModel;
	
	/**
	 * 人物视图
	 * @author noah
	 */
	public class CharacterUint extends DynamicMapUnit implements ICharacterView
	{
		public function get characterModel():ICharacterModel
		{
			return _model as ICharacterModel;
		}
		public function CharacterUint( x:int, y:int, speed:Number )
		{
			super( x, y );
			initParams["speed"] = speed;
		}
		
		override public function init():void
		{
			_model = new CharacterModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new CharacterController();
			_controller.init(_model);
			
			_model.x = initParams["x"] * MapModel.BLOCK_WIDTH;
			_model.y = initParams["y"] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			characterModel.speed = initParams["speed"];
			setPosPoint();
			update();
		}
		
		protected function onAttackHandler(e:ActionEvent):void
		{
		}
		
		override public function onUpdateHandler(event:Event):void 
		{
			super.onUpdateHandler(event);
		}
		
//		override public function draw():void{
//			
//			if(_model.isGCD){
//				if( isAniPlaying ){
//					return;
//				}
//				isAniPlaying = true;
//			} else {
//				isAniPlaying = false;
//			}
//			
////			if(_model.currentDir != _model.dir){
////				//trace("[PeopleView3D] dir" + _model.currentDir, _model.dir);
////				_model.currentDir = _model.dir;
////			}
//			super.draw();
//		}
	}
}