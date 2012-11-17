package game.untils
{
	import game.core.managers.DebugMgr;
	import game.core.managers.DisplayMgr;
	import game.core.managers.EventMgr;
	import game.core.managers.MainMgr;
	import game.core.managers.MapMgr;
	import game.core.managers.MgrType;
	import game.core.managers.ScriptMgr;
	import game.core.managers.UIMgr;

	public class MgrObjects
	{
		public static function get eventMgr():EventMgr
		{
			return MainMgr.instance.getMgr( MgrType.EVENT_MGR ) as EventMgr;
		}
		
		public static function get scriptMgr():ScriptMgr
		{
			return MainMgr.instance.getMgr( MgrType.SCRIPT_MGR ) as ScriptMgr;
		}
		
		public static function get uiMgr():UIMgr
		{
			return MainMgr.instance.getMgr( MgrType.UI_MGR ) as UIMgr;
		}
		
		public static function get displayMgr():DisplayMgr
		{
			return MainMgr.instance.getMgr( MgrType.DISPLAY_MGR ) as DisplayMgr;
		}
		
		public static function get debugMgr():DebugMgr
		{
			return MainMgr.instance.getMgr( MgrType.DEBUG_MGR ) as DebugMgr;
		}

		public static function get mapMgr():MapMgr
		{
			return MainMgr.instance.getMgr( MgrType.MAP_MGR ) as MapMgr;
		}
	}
}