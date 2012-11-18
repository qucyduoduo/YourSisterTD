package game.core.interfaces
{
	import flash.events.Event;

	public interface IPeopleModel extends IObjectModel
	{
		function get isAniPlaying():Boolean;
		function set isAniPlaying(value:Boolean):void;
		function get isGCD():Boolean;
		function set isGCD(value:Boolean):void;
	}
}