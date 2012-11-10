package controllers.tile
{
	import models.tile.TileObjectModel;
	import controllers.ObjectController;
	
	public class TileObjectController extends ObjectController
	{
		private var _model:TileObjectModel;
		
		public function TileObjectController()
		{
		}
		
		override public function init( dataObj:Object ):void{
			_model = dataObj as TileObjectModel;
		}
	}
}