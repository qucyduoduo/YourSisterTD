package  game.core.interfaces
{
	import common.base.interfaces.IModel;
	
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	public interface IObjectModel extends IModel,IEventDispatcher
	{
		function get posX():Number;
		function get posY():Number;
		/**
		 * 模型中的坐标 
		 */	
		function get modX():Number;
		function set modX(value:Number):void;
		function get modY():Number;
		function set modY(value:Number):void;
		/**
		 * gridXs 和 gridYs 用于使人模和墙壁保持距离，修正穿墙视觉bug 
		 */		
		function get gridXs():Array;
		function get gridYs():Array;
		function get gridX():uint;
		function get gridY():uint;
		function get dir():uint;
		function set dir(value:uint):void;
		/**
		 * 碰撞区域 
		 */		
		function get hitRect():Rectangle;
		function set hitRect(value:Rectangle):void;
	}
}