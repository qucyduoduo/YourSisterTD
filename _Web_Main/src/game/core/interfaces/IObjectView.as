package  game.core.interfaces
{
	import flash.events.Event;
	
	import game.untils.INode;
	
	public interface IObjectView extends INode
	{
		/**
		* 更新当前视图的视图坐标和四叉树节点数据
		* @param event
		*/		
		function onUpdateHandler(event:Event):void;
	}
}