package  game.events
{
	import common.base.events.BaseEvent;
	
	import game.starling.view.MapView3D;
	
	public class ActionEvent extends BaseEvent
	{
		public static const ATTACK:String = "attack";
		public static const CAST:String = "cast";
		
		public var mapView:MapView3D;
		
		public function ActionEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
			mapView = paramObject as MapView3D;
		}
	}
}