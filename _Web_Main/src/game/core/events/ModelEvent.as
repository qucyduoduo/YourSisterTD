package game.core.events
{
	import common.base.events.BaseEvent;
	
	public class ModelEvent extends BaseEvent
	{
		public static const UPDATE:String = "update";
		//public static const GRID_CHANGED:String = "grid_changed";
		
		public function ModelEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
		}
	}
}