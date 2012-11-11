package  game.core.controllers.dynamics
{
	import game.core.interfaces.IMapView;
	import game.core.models.dynamics.TileMonsterModel;
	
	public class TileMonsterController extends MonsterController
	{
		private var _model:TileMonsterModel;
		
		public function TileMonsterController()
		{
			super();
		}
		
		override public function init( dataObj:Object ):void{
			_model = dataObj as TileMonsterModel;
			_model.speed = 1;
		}
		/**
		 * 
		 * @param map
		 */		
		override public function onInputHandler(map:IMapView):void {
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