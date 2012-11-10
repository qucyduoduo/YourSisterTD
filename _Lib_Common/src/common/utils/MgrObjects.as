package common.utils
{
	import common.managers.EventMgr;
	import common.managers.MainMgr;
	import common.managers.MgrType;
	import common.managers.ScriptMgr;
	import common.managers.UIMgr;
	import common.nostarling.managers.DisplayMgr;
	import common.nostarling.managers.LayerMgr;
	import common.starling.managers.Display3DMgr;
	import common.starling.managers.Layer3DMgr;

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