package common.core.events
{
	import common.base.events.BaseEvent;

	public class DisplayEvent extends BaseEvent
	{
		public function DisplayEvent(type:String, paramObject:Object = null)
		{
			super(type, paramObject);
		}
	}
}