package common.listeners
{
	import common.base.listeners.BaseListener;
	import common.managers.MainMgr;
	import common.utils.MgrObjects;
	
	import flash.events.KeyboardEvent;

	/**
	 * 键盘事件侦听器
	 * @author noah
	 */
	public class KeyBoardListener extends BaseListener
	{
		/**
		 *单例模式 
		 */		
		private static var _instance:KeyBoardListener;
		
		public function KeyBoardListener()
		{
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
		}
		public static function get instance():KeyBoardListener
		{
			if(_instance == null){
				_instance = new KeyBoardListener();
			}
			return _instance;
		}
		/**
		 * 
		 */		
		public  function init():void
		{
			
		}
		/**
		 * 
		 */		
		public static function enable():void
		{
			MgrObjects.displayMgr.getStage.addEventListener(KeyboardEvent.KEY_DOWN, instance.onKeyHandler);
			MgrObjects.displayMgr.getStage.addEventListener(KeyboardEvent.KEY_UP, instance.onKeyHandler);
		}
		
		private function onKeyHandler(e:KeyboardEvent):void
		{
			MainMgr.instance.debugTrace(  "[KeyBoardListener] onKeyHandler type = " + e.type + " keyCode = " +  e.keyCode  );
			MgrObjects.eventMgr.dispatchEvent(e);
		}
		/**
		 * 
		 */		
		public static function disable():void
		{
			MgrObjects.displayMgr.getStage.removeEventListener(KeyboardEvent.KEY_DOWN, instance.onKeyHandler);
			MgrObjects.displayMgr.getStage.removeEventListener(KeyboardEvent.KEY_UP, instance.onKeyHandler);
		}
	}
}