package game.core.interfaces
{
	import flash.events.Event;
	
	
	public interface ISkillBallModel
	{
		function get modX():Number;
		function get modY():Number;
		function get posX():Number;
		function get posY():Number;
		function get gridX():uint;
		function get gridY():uint;
		function get dir():uint;
		function set dir(value:uint):void;
		function dispatchEvent( event:Event ):Boolean;
	}
}