package common.core.events
{
	import common.base.events.BaseEvent;

	/**
	 * Loading有关的事件 
	 * @author noah
	 * 
	 */	
	public class LoadEvent extends BaseEvent
	{
		/**
		 * 加载成功 
		 */		
		public static const XML_LOAD_COMPLETE:String = "xml_load_complete";
		public static const DLL_LOAD_COMPLETE:String = "dll_load_complete";
		public static const ALL_LOAD_COMPLETE:String = "all_load_complete";
		
		public function LoadEvent(type:String, paramObject:Object = null)
		{
			super(type, paramObject);
		}
	}
}