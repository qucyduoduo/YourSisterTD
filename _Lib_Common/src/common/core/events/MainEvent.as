package common.core.events
{
	import common.base.events.BaseEvent;

	public class MainEvent extends BaseEvent
	{
		public function MainEvent(type:String, paramObject:Object = null)
		{
			super(type, paramObject);
		}
	}
}