package  game.core.controllers.dynamics
{
	import common.utils.KeyPoll;
	
	import flash.ui.Keyboard;
	
	import game.base.controllers.ObjectController;
	import game.core.interfaces.IMapView;
	import game.app.managers.KeyBoardMgr;
	import game.core.models.dynamics.PeopleModel;

	/**
	 * 
	 * @author noah
	 */	
	public class PeopleController extends ObjectController
	{
		private var _model:PeopleModel;
		
		public function PeopleController(){
			super();
		}
		
		override public function init( dataObj:Object ):void{
			_model = dataObj as PeopleModel;
		}
		/**
		 * 
		 * @param map
		 */		
		public function onInputHandler(map:IMapView):void
		{
			var key:KeyPoll = KeyBoardMgr.instance.key;
			
			if(key.isDown( Keyboard.J)) {
				//近战普通攻击
				if(!_model.isGCD){
					_model.attack( map );
				}
				
			} else if(key.isDown( Keyboard.K)) {
				//远程普通攻击
				if(!_model.isGCD){
					_model.cast( map );
				}
				
			} else if(!_model.isGCD) {
				//八方向移动，没有移动则恢复成站立
				if(key.isDown( Keyboard.W )){
					if(key.isDown( Keyboard.A )){
						_model.dir = 6 + 8;
					} else if(key.isDown( Keyboard.D )){
						_model.dir =  4 + 8;
					} else {
						_model.dir =  5 + 8;
					}
				} else if(key.isDown( Keyboard.S )){
					if(key.isDown( Keyboard.A )){
						_model.dir =  8 + 8;
					} else if(key.isDown( Keyboard.D )){
						_model.dir =  2 + 8;
					} else {
						_model.dir =  1 + 8;
					}
				} else if(key.isDown( Keyboard.A )){
					_model.dir =  7 + 8;
				} else if(key.isDown( Keyboard.D )){
					_model.dir =  3 + 8;
				} else {
					if( !_model.isAniPlaying){
						if( _model.dir - 8 >= 1 ){
							_model.dir = (_model.dir % 8 != 0)?_model.dir%8:8;
						}
					}
				}
				this._model.move( map.model );
			}
		}
	}
}