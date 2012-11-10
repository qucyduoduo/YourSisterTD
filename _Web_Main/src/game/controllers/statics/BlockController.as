package  game.controllers.statics
{
	import game.controllers.base.ObjectController;
	import game.models.statics.BlockModel;

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