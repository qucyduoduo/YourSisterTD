package game.interfaces
{
	import flash.events.Event;

	public interface IPeopleModel
	{
		function heated( model:* ):void;
		
		function get modX():Number;
		function get modY():Number;
		function get posX():Number;
		function get posY():Number;
		function get isAniPlaying():Boolean;
		function set isAniPlaying(value:Boolean):void;
		function get gridX():uint;
		function get gridY():uint;
		function get dir():uint;
		function set dir(value:uint):void;
		function get isGCD():Boolean;
		function set isGCD(value:Boolean):void;
		function dispatchEvent( event:Event ):Boolean;
	}
}