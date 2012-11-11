package  game.core.controllers
{
	import game.core.interfaces.IMapView;
	
	import game.core.models.TileSkillBallModel;

	public class TileSkillBallController extends TileObjectController
	{
		private var _model:TileSkillBallModel;
		
		public function TileSkillBallController()
		{
			super();
		}
		override public function init( dataObj:Object ):void{
			_model = dataObj as TileSkillBallModel;
		}
		
		public function onInputHandler(map:IMapView):void
		{
			this._model.move( map.model );
		}
		
	}
}