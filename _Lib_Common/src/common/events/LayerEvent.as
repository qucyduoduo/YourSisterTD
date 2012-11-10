package common.events
{
	import common.base.events.BaseEvent;

	public class LayerEvent extends BaseEvent
	{
		public function LayerEvent(type:String, paramObject:Object = null)
		{
			super(type, paramObject);
		}
	}
}