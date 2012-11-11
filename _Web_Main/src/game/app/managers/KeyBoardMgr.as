package  game.app.managers
{
	import common.utils.KeyPoll;
	
	import flash.display.Stage;

	/**
	 * 键盘事件管理器
	 * @author noah
	 */	
	public class KeyBoardMgr
	{
		public var key:KeyPoll;
		/**
		 *单例模式 
		 */		
		private static var _instance:KeyBoardMgr;
		/**
		 * 单例访问器
		 * @return 
		 */
		public static function get instance():KeyBoardMgr {
			if(_instance == null) {
				_instance = new KeyBoardMgr();
			}
			return _instance;
		}
		/**
		 * 构造函数
		 */		
		public function KeyBoardMgr() {
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
		}
		/**
		 * 
		 * @param stage
		 */		
		public function init( stage:Stage ):void{
			key = new KeyPoll( stage );
		}
	}
}