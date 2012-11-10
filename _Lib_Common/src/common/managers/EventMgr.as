package common.managers
{
	import common.base.interfaces.IMgr;
	import common.listeners.KeyBoardListener;
	import common.listeners.MouseListener;
	
	import flash.events.EventDispatcher;

	/**
	 * 事件管理器
	 * @author noah
	 * 
	 */
	public class EventMgr extends EventDispatcher implements IMgr
	{
		private var _isDisposed:Boolean;
		/**
		 * 构造函数
		 */		
		public function EventMgr()
		{

		}
		/**
		 * 初始化
		 */		
		public function init():void
		{
			KeyBoardListener.instance.init();
			MouseListener.instance.init();
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