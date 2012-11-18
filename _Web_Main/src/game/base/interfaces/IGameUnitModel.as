package  game.base.interfaces
{
	import common.base.interfaces.IModel;
	
	import flash.events.IEventDispatcher;
	
	public interface IGameUnitModel extends IModel, IEventDispatcher
	{
		function get type():int;
		function set type(value:int):void;
		
		function get dir():uint;
		function set dir(value:uint):void;
	}
}