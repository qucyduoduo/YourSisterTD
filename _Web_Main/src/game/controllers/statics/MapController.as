package  game.controllers.statics
{
	import common.base.controllers.BaseController;
	import org.rpg.models.MapModel;
	
	public class MapController extends BaseController
	{
		private var _model:MapModel;
		
		public function MapController()
		{
			super();
		}
		
		override public function init( dataObj:Object ):void{
			
			_model = dataObj as MapModel;
		}
	}
}