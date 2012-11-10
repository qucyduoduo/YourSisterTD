package common.events
{
	import common.base.events.BaseEvent;

	public class ScriptEvent extends BaseEvent
	{
		public function ScriptEvent(type:String, paramObject:Object = null)
		{
			super(type, paramObject);
		}
	}
}