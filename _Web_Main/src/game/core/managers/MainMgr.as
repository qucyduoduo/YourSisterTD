package game.core.managers
{
	import common.base.managers.BaseMgr;
	import common.utils.UILoader;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import game.starling.GameWorld;
	import game.untils.MgrObjects;
	
	import starling.core.Starling;

	/**
	 * 全局管理类(单例 + 静态方法)
	 * 控制其他管理类
	 * @author noah
	 * 
	 */
	public class MainMgr extends BaseMgr
	{
		private var _starlingEngine:Starling;
		
		protected static var _instance:MainMgr;
		
		public static function get instance() : MainMgr
		{
			if (_instance == null)
			{
				_instance = new MainMgr();    
			}
			return _instance;
		}
		/**
		 * 构造函数
		 */		
		public function MainMgr()
		{
			super();
		}
		
		private var _startTime:uint;
		
		public function startTimeCount():void
		{
			_startTime = getTimer();
		}
		
		public function endTimeCount():String
		{
			var returnTime:uint = getTimer() - _startTime;
			startTimeCount();
			return returnTime + " ms";
		}
		/**
		 * initialization engine
		 * @param _root
		 * @param debugMode
		 */
		public function init(_root:Sprite, debugMode:Boolean ):void
		{
			startTimeCount();
			
			_debugMode = debugMode;

			addManagers();

			MgrObjects.displayMgr.init( _root );

			MgrObjects.debugMgr.log( "MainMgr.init _debugMode = " + debugMode );
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			_starlingEngine = new Starling( GameWorld, MgrObjects.displayMgr.getStage, new Rectangle(0,0,960,640),null,"auto","baseline");
			_starlingEngine.start();
		}
		
		/**
		 * add global managers
		 */		
		private function addManagers():void
		{
			MainMgr.instance.addMgr( MgrType.EVENT_MGR , new EventMgr() );
			MainMgr.instance.addMgr( MgrType.SCRIPT_MGR , new ScriptMgr() );
			MainMgr.instance.addMgr( MgrType.UI_MGR , new UIMgr() );
			MainMgr.instance.addMgr( MgrType.DISPLAY_MGR , new DisplayMgr() );
			MainMgr.instance.addMgr( MgrType.DEBUG_MGR , new DebugMgr() );
			MainMgr.instance.addMgr( MgrType.MAP_MGR , new MapMgr() );
		}
		
		/**
		 * 
		 */		
		public function loadUI():void
		{
			/*AlertController.show("你确定吗？",function():void{
				MainMgr.debugTrace("[loadUI] true");
			},function():void{
				MainMgr.debugTrace("[loadUI] false");
			});*/
			
			debugTrace("[MainMgr]加载UI库");
			UILoader.load(onLoadUICompleteHandler);
		}
		/**
		 * 
		 * @param e
		 */		
		private function onLoadUICompleteHandler( _loader:Loader ):void
		{
			MgrObjects.uiMgr.init(  _loader );
			MgrObjects.scriptMgr.init();
		}
	}
}