package common.events
{
	import common.base.events.BaseEvent;

	public class AlertEvent extends BaseEvent
	{
		/**
		 * 
		 */		
		public static const ALERT_CLOSE_EVENT:String = "alert_close_event";
		
		public function AlertEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
		}
	}
}