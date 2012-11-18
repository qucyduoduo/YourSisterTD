package game.core.interfaces
{
	import game.untils.QuadNode;
	import game.untils.QuadTrees;
	import game.base.interfaces.IGameUnitModel;

	/**
	 * 四叉树节点接口
	 */	
	public interface INode 
	{
		function get model():IGameUnitModel;
		function get node():QuadNode;
		function set node(value:QuadNode):void;
		function get tree():QuadTrees;
		function set tree(value:QuadTrees):void;
		function unload():void;
	}
}