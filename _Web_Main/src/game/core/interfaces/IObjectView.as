package  game.core.interfaces
{
	import common.utils.interfaces.INode;
	
	import flash.events.Event;
	
	public interface IObjectView extends INode
	{
		/**
		* 更新当前视图的视图坐标和四叉树节点数据
		* @param event
		*/		
		function onUpdateHandler(event:Event):void;
	}
}