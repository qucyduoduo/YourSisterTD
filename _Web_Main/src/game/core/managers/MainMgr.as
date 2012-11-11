package game.core.managers
{
	import common.base.managers.BaseMgr;
	import common.utils.UILoader;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	
	import game.untils.MgrObjects;
	
	import starling.core.Starling;
	import starling.display.Quad;

	/**
	 * 全局管理类(单例 + 静态方法)
	 * 控制其他管理类
	 * @author noah
	 * 
	 */
	public class MainMgr extends BaseMgr
	{
		protected static var _instance:MainMgr;
		
		public static function get instance() : MainMgr
		{
			if (_instance == null)
			{
				_instance = new MainMgr ();    
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
		/**
		 * 初始化引擎
		 * @param _root
		 * @param debugMode
		 */
		public function init(_root:Sprite, debugMode:Boolean ):void
		{
			_debugMode = debugMode;
			//显示
			MgrObjects.displayMgr.init( _root );
			//基础
			MgrObjects.layerMgr.init();
			//事件
			MgrObjects.eventMgr.init();
			Starling.multitouchEnabled = true;
		}
		
		private var q:Quad;
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
		private function onLoadUICompleteHandler( _loader:Loader ):void{
			
			//用户界面
			MgrObjects.uiMgr.init(  _loader );
			//用户
			//UserMgr.init();
			//资源
			//ResourceMgr.init();
			//脚本
			MgrObjects.scriptMgr.init();
			//扩展
			//ExternalMgr.init();
			
			//图像
			//GraphicMgr.init();
			//动画
			//AnimationMgr.init();
			//特效
			//EffectMgr.init();
			//声音
			//SoundMgr.init();
			//文本
			//TextMgr.init();
			
			//缓存
			//CacheMgr.init();
			//数据
			//DataMgr.init();
			//流程
			//ProcessMgr.init();
			
			
			//地图
			//战斗
			//怪物
			
		}
	}
}