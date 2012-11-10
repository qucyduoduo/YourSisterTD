package common.base.events
{
	import common.base.interfaces.IEvent;
	
	import flash.events.Event;

	/**
	 * 事件基类
	 * 
	 * 所有事件类都必须继承这个类
	 * @author noah
	 */	
	public class BaseEvent extends Event implements IEvent
	{
		protected var _paramObject:Object;
		
		public function BaseEvent(type:String, paramObject:Object = null)
		{
			super(type, false, false);
			_paramObject = paramObject;
		}
		
		public function get paramObject() : Object
		{
			return _paramObject;
		}
		
		override public function clone() : Event
		{
			return new BaseEvent(type, _paramObject);
		}
	}
}