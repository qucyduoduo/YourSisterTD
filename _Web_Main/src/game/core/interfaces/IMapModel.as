package game.core.interfaces
{
	public interface IMapModel
	{
		/**
		 * 碰撞检测
		 * @param pm
		 * @return 
		 */		
		function onHitTestGrid( p:* ):Boolean;
		function get dataArr():Array;
		function set dataArr(value:Array):void;
		
	}
}