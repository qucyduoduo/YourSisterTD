package game.core.unit.starling
{
	import common.utils.QuadNode;
	import common.utils.QuadTrees;
	
	import flash.events.Event;
	
	import game.base.controllers.ObjectController;
	import game.base.models.ObjectModel;
	import game.base.starling.GameUint;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IObjectController;
	import game.core.interfaces.IObjectModel;
	import game.core.interfaces.IObjectView;

	/**
	 * 物体视图
	 * @author noah
	 */	
	public class Map3DUnit extends GameUint implements IObjectView
	{
		/**
		 * 模型 
		 */		
		private var _model:IObjectModel;
		/**
		 * 控制器 
		 */		
		private var _controller:IObjectController;
		/**
		 * 四叉树节点
		 */		
		protected var _node:QuadNode;
		/**
		 * 四叉树引用 
		 */		
		protected var _tree:QuadTrees;
		/**
		 * 构造函数
		 */
		public function Map3DUnit()
		{
			super();
		}
		
		/**
		 * 初始化
		 * @param data
		 */		
		override public function init(data:Object = null):void
		{
			_model = new ObjectModel();
			_controller = new ObjectController();
			_controller.init( _model );
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
		}
		/**
		 * 更新视图
		 */		
		override public function update():void
		{
			//更新视图坐标`
			super.x = model.posX;
			super.y = model.posY;
		}
		/**
		 * 
		 * @param event
		 */		
		public function onUpdateHandler(event:Event):void
		{
			this.update();
			//更新四叉树节点
			if(tree){
				var xx:Number;
				var yy:Number;
				var str:String;
				var nodeNew:QuadNode;
				if (node){
					if( node.id != model.gridX + "-" + model.gridY){
						xx = int(model.modX / node.rect.width);
						yy = int(model.modY / node.rect.height);
						str = xx + "-" + yy;
						//trace("[ObjectView3D] "+str);
						nodeNew = tree.nodes.get(str) as QuadNode;
						reset(node, nodeNew);
						node = nodeNew;
					}
				}
			}
		}
		/**
		 * 
		 * @param node1
		 * @param node2
		 */		
		protected function reset(node1:QuadNode, node2:QuadNode):void
		{
			if (node1 && node2){
				if (node1 != node2){
					node1.remove(this);
					node2.add(this);
				}
			}
		}
		
		public function get model():*{
			return _model;
		}
		
		override public function set x(value:Number):void{
			super.x = value;
		}
		override public function get x():Number{
			return super.x;
		}
		override public function set y(value:Number):void{
			super.y = value;
		}
		override public function get y():Number{
			return super.y;
		}
		public function get node():QuadNode {
			return this._node;
		}
		public function set node(value:QuadNode):void {
			this._node = value;
		}
		public function get tree():QuadTrees {
			return this._tree;
		}
		public function set tree(value:QuadTrees):void {
			this._tree = value;
		}
		public function unload():void{
			if(this._node!=null){
				this._node.remove(this);
				this._node = null;
			}
			this._tree = null;
		}
	}
}