package game.core.events
{
	import common.base.events.BaseEvent;
	
	public class ModelEvent extends BaseEvent
	{
		public static const UPDATE_TYPE:String = "updateType";
		public static const UPDATE_X:String = "updateX";
		public static const UPDATE_Y:String = "updateY";
		public static const UPDATE_DIR:String = "updateDir";
		public static const UPDATE:String = "update";
		
		public function ModelEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
		}
	}
}