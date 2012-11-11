package  game.core.controllers.dynamics
{
	import game.base.controllers.ObjectController;
	import game.core.interfaces.IMapView;
	import game.core.models.dynamics.MonsterModel;

	/**
	 * 
	 * @author noah
	 */	
	public class MonsterController extends ObjectController {
		
		private var _model:MonsterModel;
		
		protected var timer:uint = 0;
		protected var tempDir:uint = 0;
		/**
		 * 
		 */		
		public function MonsterController() {
			super();
		}
		
		override public function init( dataObj:Object ):void{
			_model = dataObj as MonsterModel;
		}
		
		/**
		 * 
		 * @param map
		 */		
		public function onInputHandler(map:IMapView):void {
			
			if(timer > 0){
				//timer = 0;
				tempDir = 1;
			}
			if(timer == 0){
				tempDir = Math.random()*8 + 9;
			}
			timer ++ ;
			_model.dir = tempDir;
			this._model.move( map.model );
		}
	}
}