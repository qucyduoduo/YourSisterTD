package game.untils
{
	/**
	 * 四叉树节点接口
	 */	
	public interface INode {
		function get model():*;
		function set x(value:Number):void;
		function get x():Number;
		function set y(value:Number):void;
		function get y():Number;
		function get node():QuadNode;
		function set node(value:QuadNode):void;
		function get tree():QuadTrees;
		function set tree(value:QuadTrees):void;
		function unload():void;
	}
}