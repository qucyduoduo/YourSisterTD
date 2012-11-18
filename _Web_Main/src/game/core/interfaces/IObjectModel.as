package  game.core.interfaces
{
	import common.base.interfaces.IModel;
	
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	public interface IObjectModel extends IModel,IEventDispatcher
	{
		function get type():int;
		function set type(value:int):void;
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get dir():uint;
		function set dir(value:uint):void;
	}
}