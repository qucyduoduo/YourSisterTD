package org.rpg.managers
{
	import common.base.managers.BaseMgr;
	
	/**
	 * 技能管理器 
	 * @author noah
	 * 
	 */
	public class SkillMgr extends BaseMgr
	{
		/**
		 *单例模式 
		 */		
		private static var _instance:SkillMgr;
		/**
		 * 单例访问器
		 * @return 
		 */		
		public static function get instance():SkillMgr {
			if(_instance == null) {
				_instance = new SkillMgr();
			}
			return _instance;
		}
		
		/**
		 * 
		 */		
		public function SkillMgr()
		{
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
		}
	}
}