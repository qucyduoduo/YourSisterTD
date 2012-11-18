package game.untils
{
	import game.core.interfaces.INode;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 *  四叉树的节点
	 */
	public class QuadNode {
		//四个子节点
		private var oneNode:QuadNode = null;
		private var twoNode:QuadNode = null ;
		private var threeNode:QuadNode = null ;
		private var fourNode:QuadNode = null ;
		//此节点的范围
		private var _rect:Rectangle  = null ;
		//此节点的父亲节点
		public var parentNode:QuadNode = null ;
		//是否有子节点
		public var hasSon:Boolean = true ;
		//此节点下所有的对象集合
		public var objVec:Vector.<INode> = new Vector.<INode>();
		//此节点的儿子节点集合
		public var sonNodeList:Vector.<QuadNode> = new Vector.<QuadNode>();
		
		public var id:String;
		
		public function QuadNode(){
			sonNodeList.push(oneNode);
			sonNodeList.push(twoNode);
			sonNodeList.push(threeNode);
			sonNodeList.push(fourNode);
		}
		/**
		 * 判断点是否在此节点中 
		 * @param point
		 * @return 
		 */	
		public function checkPointIsIn(point:Point):Boolean{
			if(point.x>=this.rect.x&&point.y>=this.rect.y&&point.x<this.rect.x+this.rect.width&&point.y<this.rect.y+this.rect.height){
				return true;
			}
			return false;
		}
		/** 
		 * 判断是否是叶子节点
		 * @param node
		 * @return 
		 */	
		public function isLeaf(node:QuadNode):Boolean{
			if(this.parentNode!=null&&node.parentNode!=null&&this.parentNode==node.parentNode){
				return true;
			}
			return false;
		}
		
		public function remove(obj:INode):void{
			for(var i:int = 0;i<this.objVec.length ; i++){
				if(this.objVec[i]==obj){
					this.objVec.splice(i,1);
					break;
				}
			}
		}
		
		public function add(obj:INode):void{
			this.objVec.push(obj);
		}
		
		/**
		 * 
		 */		
		public function dispose():void {
			if(sonNodeList) {
				for each( var node:QuadNode in sonNodeList) {
					if(node) node.dispose() ;
				}
			}
			
			if(objVec) {
				for each( var mc:INode in objVec) {
					mc = null ;
				}
				objVec = new Vector.<INode>();
			}
		}
		/**
		 * 
		 * @return 
		 */		
		public function get rect():Rectangle {
			return _rect;
		}
		/**
		 * 
		 * @param value
		 */		
		public function set rect(value:Rectangle):void {
			_rect = value;
			id = int(rect.x / rect.width) + "-" + int(rect.y / rect.height);
		}
	}
}