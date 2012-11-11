package  game.core.statics
{
	import game.base.controllers.ObjectController;
	import game.core.models.statics.BlockModel;

	public class BlockController extends ObjectController
	{
		private var _model:BlockModel;
		
		public function BlockController()
		{
			
		}
		
		override public function init( dataObj:Object ):void{
			_model = dataObj as BlockModel;
		}
	}
}