package game.core.controllers
{
	import flash.ui.Keyboard;
	
	import common.base.controllers.BaseController;
	import game.core.interfaces.IMapView;
	import org.rpg.managers.KeyBoardMgr;
	import game.core.models.SkillBallModel;

	public class SkillBallController extends ObjectController
	{
		private var _model:SkillBallModel;
		
		public function SkillBallController()
		{
			super();
		}
		override public function init( dataObj:Object ):void{
			_model = dataObj as SkillBallModel;
		}
		
		public function onInputHandler(map:IMapView):void
		{
			this._model.move( map.model );
		}
	}
}