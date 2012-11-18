package common.utils
{
	import common.utils.interfaces.INode;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 四叉树 
	 */	
	public class QuadTrees 
	{
		//四叉树的层数
		private var _layerNum:int = 0;
		//最大的范围
		private var _maxRect:Rectangle  = null ;
		//主节点
		private var _mainNode:QuadNode = null ;
		//节点集合
		private var _nodeList:Vector.<QuadNode> = null ;
		
		public var nodes:HashMap;
		
		/**
		 *  四叉树构造函数
		 * @param layerNum 四叉树的层数
		 * @param maxRect 最大的范围
		 */		
		public function QuadTrees( layerNum:int , maxRect:Rectangle ) 
		{
			this._layerNum = layerNum+1 ; //四叉树的层数
			nodes = new HashMap();
			_maxRect = maxRect ;
			_nodeList = new Vector.<QuadNode>();
			//初始化树的根节点
			_mainNode = new QuadNode();
			_mainNode.hasSon = true ;
			_mainNode.rect = this._maxRect ;
			initTree( _mainNode );
		}
		/**
		 * 初始化树
		 * @node 树节点
		 */
		private function initTree( node:QuadNode):void 
		{
			if(node==null || node.rect.width<=this._maxRect.width/Math.pow(2,_layerNum ) || node.rect.height<=this._maxRect.height/Math.pow(2,_layerNum ) )
			{
				var key:String = node.rect.x/node.rect.width + "-" + node.rect.y/node.rect.height;
				nodes.put(key,node);
				node.hasSon = false ;
				return ;
			}
			_nodeList.push( node );
			//设置子节点
			for( var i:int=0; i<node.sonNodeList.length; ++i)
			{
				node.sonNodeList[i]= new QuadNode();
				node.sonNodeList[i].parentNode = node; 
				node.sonNodeList[i].rect = new Rectangle( node.rect.x + (i % 2) * node.rect.width*0.5, node.rect.y + int( i > 1) * node.rect.height*0.5, node.rect.width*0.5, node.rect.height*0.5);
				initTree(node.sonNodeList[i]); 
			}
		}
		/**
		 * 添加可视对象到树中 
		 * @param obj 类型为DisplayObjects
		 */		
		public function insertObj( obj:INode ):void 
		{
			var sonNode:QuadNode = searchNodeByPoint(new Point(obj.model.x, obj.model.y) , _mainNode );
			sonNode.objVec.push( obj );
			obj.node = sonNode;
			obj.tree = this;
		}
		/**
		 * 从树中删除对象 
		 * @param obj
		 */		
		public function deleteObj(obj:INode):void 
		{
			var sonNode:QuadNode = searchNodeByPoint(new Point(obj.model.modX,obj.model.modY) , _mainNode );
			for(var i:int = 0;i<sonNode.objVec.length ; i++){                 
				if(sonNode.objVec[i]==obj){                     
					sonNode.objVec.splice(i,1);                     
					break;    
				}             
			} 
		}
		/**
		 * 遍历节点和儿子节点，查找最终的对象 
		 * @param objVec 查询结果
		 * @param rect 范围
		 * @param tempNode
		 */		
		private function queryAndAdd(objVec:Vector.<INode>,rect:Rectangle ,  tempNode:QuadNode ,exact:Boolean ):void
		{
			//如果没有交集，则返回
			if(!rect.intersects(tempNode.rect))
			{
				return;
			}
			//判断是否有儿子节点，递归找儿子
			if(tempNode.hasSon)
			{
				//遍历儿子节点
				for each(var son:QuadNode in tempNode.sonNodeList){
					if(son.rect.intersects(rect)){ 
						queryAndAdd(objVec,rect, son ,exact);
					}
				}
			}
			else
			{
				//如果是最后的节点，则把里面的对象加入数组中
				for each(var obj:INode in tempNode.objVec)
				{
					if(exact){
						var sonRect:Rectangle = new Rectangle(obj.model.modX,obj.model.modY,DisplayObject(obj).width,DisplayObject(obj).height) ;
						if(sonRect.intersects(rect)){
							objVec.push( obj );
						}
					}else{
						objVec.push( obj );
					}
				}
			}
		}
		/**
		 * 通过坐标来找节点 
		 * @param point
		 * @return 
		 */		
		private function searchNodeByPoint( point:Point ,node:QuadNode ):QuadNode
		{
			if(node.hasSon)
			{
				if(node.checkPointIsIn(point))
				{
					//遍历儿子节点
					for each(var son:QuadNode in node.sonNodeList)
					{
						if(son.checkPointIsIn(point ))
						{
							node = searchNodeByPoint( point , son );
						}
					}
				}
			}
			return node ;
		}
		/**
		 * 从四叉树中移除所有 
		 */		
		public function removeAll():void 
		{
			for each( var node:QuadNode in _nodeList) 
			{
				node.dispose() ;
			}
		}
	}
}