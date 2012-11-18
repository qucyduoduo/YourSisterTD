package game.base.units
{
	import flash.events.Event;
	
	import game.base.interfaces.IStaticUnitModel;
	import game.base.models.StaticUnitModel;
	import game.core.events.ModelEvent;
	import game.core.models.statics.MapModel;
	import game.core.statics.StaticUnitController;
	
	import starling.display.Quad;
	
	/**
	 * 静态物体视图
	 * @author noah
	 */	
	public class StaticMapUnit extends MapUnit
	{
		protected var initParams:Object;
		protected var posPoint:Quad;

		public function get staticUnitModel():IStaticUnitModel
		{
			return _model as IStaticUnitModel;
		}
		
		public function StaticMapUnit( x:int, y:int )
		{
			initParams = {"x":x, "y":y};
		}
		
		override public function init():void
		{
			_model = new StaticUnitModel();
			_controller = new StaticUnitController();
			_controller.init(_model);
			
			_model.x = initParams["x"] * MapModel.BLOCK_WIDTH;
			_model.y = initParams["y"] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, this.onUpdateHandler);
			
			setPosPoint();
		}
		
		protected function setPosPoint():void
		{
			posPoint = new Quad(3,3,0xff0000);
			posPoint.x = -1;
			posPoint.y = -1;
			addChild(posPoint);
		}
		
		override public function onUpdateHandler(event:Event):void 
		{
			super.onUpdateHandler(event);
		}
	}
}