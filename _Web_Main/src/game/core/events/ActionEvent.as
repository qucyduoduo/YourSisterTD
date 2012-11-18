package  game.core.events
{
	import common.base.events.BaseEvent;
	
	import game.core.map.MapView;
	
	public class ActionEvent extends BaseEvent
	{
		public static const ATTACK:String = "attack";
		public static const CAST:String = "cast";
		
		public var mapView:MapView;
		
		public function ActionEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
			mapView = paramObject as MapView;
		}
	}
}