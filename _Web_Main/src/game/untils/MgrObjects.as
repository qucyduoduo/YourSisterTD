package game.untils
{
	import game.core.managers.EventMgr;
	import game.core.managers.MainMgr;
	import game.core.managers.MgrType;
	import game.core.managers.ScriptMgr;
	import game.core.managers.UIMgr;
	import game.core.managers.nostarling.DisplayMgr;
	import game.core.managers.nostarling.LayerMgr;
	import game.core.managers.starling.Display3DMgr;
	import game.core.managers.starling.Layer3DMgr;

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
		
		public static function get layerMgr():LayerMgr
		{
			return MainMgr.instance.getMgr( MgrType.LAYER_MGR ) as LayerMgr;
		}
		
		public static function get display3DMgr():Display3DMgr
		{
			return MainMgr.instance.getMgr( MgrType.DISPLAY3D_MGR ) as Display3DMgr;
		}
		
		public static function get layer3DMgr():Layer3DMgr
		{
			return MainMgr.instance.getMgr( MgrType.LAYER3D_MGR ) as Layer3DMgr;
		}
	}
}