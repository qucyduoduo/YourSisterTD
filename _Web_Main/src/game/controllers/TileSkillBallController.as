package  game.controllers
{
	import game.interfaces.IMapView;
	
	import org.rpg.models.tile.TileSkillBallModel;

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