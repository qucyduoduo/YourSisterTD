package  game.core.events
{
	import common.base.events.BaseEvent;
	
	import game.core.map.starling.Map3D;
	
	public class ActionEvent extends BaseEvent
	{
		public static const ATTACK:String = "attack";
		public static const CAST:String = "cast";
		
		public var mapView:Map3D;
		
		public function ActionEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
			mapView = paramObject as Map3D;
		}
	}
}