package game.events
{
	import common.base.events.BaseEvent;
	
	import flash.geom.Point;
	
	public class MoveEvent extends BaseEvent
	{
		//public static const DIR_CHANGE:String = "dir_change";
		public static const OBJECT_MOVE:String = "object_move";
		
		
		public var pos:Point;
		
		public function MoveEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
			pos = paramObject as Point;
		}
	}
}