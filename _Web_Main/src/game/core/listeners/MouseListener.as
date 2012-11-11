package game.core.listeners
{
	import common.base.listeners.BaseListener;
	import game.core.managers.EventMgr;
	import game.core.managers.MainMgr;
	import game.core.managers.MgrType;
	import common.utils.MgrObjects;
	
	import flash.events.MouseEvent;

	/**
	 * 鼠标事件侦听器
	 * @author noah
	 */
	public class MouseListener extends BaseListener
	{
		/**
		 *单例模式 
		 */		
		private static var _instance:MouseListener;
		
		public function MouseListener()
		{
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
		}
		public static function get instance():MouseListener
		{
			if(_instance == null){
				_instance = new MouseListener();
			}
			return _instance;
		}
		/**
		 * 
		 */		
		public function init():void
		{
		
		}
		/**
		 * 
		 */		
		public function enable():void
		{
			MgrObjects.displayMgr.getStage.addEventListener(MouseEvent.MOUSE_DOWN, instance.onMouseHandler);
			MgrObjects.displayMgr.getStage..addEventListener(MouseEvent.MOUSE_UP, instance.onMouseHandler);
		}
		
		private function onMouseHandler(e:MouseEvent):void{
			
			MainMgr.instance.debugTrace(  "[MouseListener] onMouseHandler type = " + e.type );
			(MainMgr.instance.getMgr( MgrType.EVENT_MGR ) as EventMgr).dispatchEvent(e);
		}
		/**
		 * 
		 */		
		public static function disable():void
		{
			MgrObjects.displayMgr.getStage.removeEventListener(MouseEvent.MOUSE_DOWN, instance.onMouseHandler);
			MgrObjects.displayMgr.getStage..removeEventListener(MouseEvent.MOUSE_UP, instance.onMouseHandler);
		}
	}
}