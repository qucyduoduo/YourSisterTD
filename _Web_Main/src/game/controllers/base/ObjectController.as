package  game.controllers.base
{
	import common.base.controllers.BaseController;
	
	import game.interfaces.IObjectController;
	import game.interfaces.IObjectModel;
	import game.models.base.ObjectModel;
	
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