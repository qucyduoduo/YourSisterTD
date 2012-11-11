package game.core.managers.nostarling
{
	import common.base.interfaces.IMgr;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	/**
	 * 显示对象管理器
	 * @author noah
	 */
	public class DisplayMgr implements IMgr
	{
		/**
		 * 入口类
		 */		
		private var _root:Sprite;			
		/**
		 * 舞台引用
		 */		
		private var _stage:Stage;
		private var _isDisposed:Boolean;
		/**
		 * 构造函数
		 */		
		public function DisplayMgr()
		{
			
		}
		/**
		 * 初始化
		 * @param con:Sprite 层管理器的容器
		 */		
		public function init(con:Sprite):void{
			
			_root = con;
			_stage = con.stage;
		}
		/**
		 * 
		 * @return 
		 */		
		public function getStageRect():Rectangle{
			
			return new Rectangle(0,0, _stage.stageWidth, _stage.stageHeight);
		}
		/**
		 * 从父容器中移除
		 * @param mc 被移除的子显示对象
		 */		
		public function removeForParent(mc:DisplayObject):void{
			var parentMc:DisplayObjectContainer;
			if(mc.parent)
			{
				parentMc = mc.parent as DisplayObjectContainer;
				parentMc.removeChild(mc);
				mc = null;
				parentMc = null;
			}
		}
		/**
		 * 移除layer上所有child 
		 * @param layer
		 */		
		public function removeAllAt(layer:DisplayObjectContainer):void
		{
			var len:uint = layer.numChildren;
			while(len>0)
			{
				layer.removeChildAt(0);
				len--;
			}
		}
		/**
		 * 获得舞台引用
		 * @return 
		 */		
		public function get getStage():Stage
		{
			return _stage;
		}
		
		public function dispose():void
		{
			if(_isDisposed == false)
			{
				distruct();
				_isDisposed = true;
			}
		}
		
		protected function distruct():void
		{
			//TODO dispose resource table.
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}