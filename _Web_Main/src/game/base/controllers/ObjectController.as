package  game.base.controllers
{
	import common.base.controllers.BaseController;
	
	import game.core.interfaces.IObjectController;
	import game.core.interfaces.IObjectModel;
	import game.base.models.ObjectModel;
	
	public class ObjectController extends BaseController implements IObjectController
	{
		private var _model:IObjectModel;
		
		public function ObjectController(){
			
		}
		
		override public function init( dataObj:Object ):void
		{
			_model = dataObj as ObjectModel;
		}
	}
}