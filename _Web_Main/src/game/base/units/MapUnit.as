package game.base.units
{
	import flash.events.Event;
	
	import game.base.controllers.GameUnitController;
	import game.base.models.GameUnitModel;
	import game.core.events.ModelEvent;
	import game.core.interfaces.view.IMapUnitView;
	import game.untils.QuadNode;
	import game.untils.QuadTrees;

	/**
	 * 物体视图
	 * @author noah
	 */	
	public class MapUnit extends GameUint implements IMapUnitView
	{
		private var _tree:QuadTrees;
		private var _node:QuadNode;
		/**
		 * 构造函数
		 */
		public function MapUnit()
		{
			super();
		}
		
		override public function init():void
		{
			_model = new GameUnitModel();
			_controller = new GameUnitController();
			_controller.init( _model );
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
		}
		
		/**
		 * 更新视图
		 */		
		override public function update():void
		{
			super.x = model.x;
			super.y = model.y;
		}
		/**
		 * 
		 * @param event
		 */		
		public function onUpdateHandler(event:Event):void
		{
			this.update();
			//更新四叉树节点
			if(tree)
			{
				var xx:Number;
				var yy:Number;
				var str:String;
				var nodeNew:QuadNode;
				if (node){
					if( node.id != model.x + "-" + model.y)
					{
						xx = int(model.x / node.rect.width);
						yy = int(model.y / node.rect.height);
						str = xx + "-" + yy;
						trace("[MapUnit] onUpdateHandler = " + str);
						nodeNew = tree.nodes.get(str) as QuadNode;
						reset(node, nodeNew);
						node = nodeNew;
					}
				}
			}
		}
		
		protected function reset(node1:QuadNode, node2:QuadNode):void
		{
			if (node1 && node2)
			{
				if (node1 != node2)
				{
					node1.remove(this);
					node2.add(this);
				}
			}
		}
		
		override public function advanceTime( time:Number ):void
		{
			super.advanceTime( time );
		}
		
		override protected function updateFrame():void
		{
			super.updateFrame();
		}
		
		override public function stop():void
		{
			super.stop();
		}
		
		override protected function checkMotionIsFinished():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function get node():QuadNode 
		{
			return this._node;
		}
		public function set node(value:QuadNode):void 
		{
			this._node = value;
		}
		public function get tree():QuadTrees 
		{
			return this._tree;
		}
		public function set tree(value:QuadTrees):void 
		{
			this._tree = value;
		}
		public function unload():void
		{
			if(this._node!=null)
			{
				this._node.remove(this);
				this._node = null;
			}
			this._tree = null;
		}
	}
}