package
{
	import common.utils.TextTool;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	import game.core.managers.EventMgr;
	import game.core.managers.MainMgr;
	import game.core.managers.MgrType;
	import game.core.managers.ScriptMgr;
	import game.core.managers.UIMgr;
	import game.core.managers.nostarling.DisplayMgr;
	import game.core.managers.nostarling.LayerMgr;
	import game.core.managers.starling.Display3DMgr;
	import game.core.managers.starling.Layer3DMgr;
	import game.nostarling.GameWorld;
	import game.starling.GameWorld;
	
	import starling.core.Starling;
	
	[SWF(width="960", height="640", frameRate="60",backgroundColor="0x000000")]
	public class _Web_Main extends Sprite
	{
		private var _starlingEngine:Starling;
		/**
		 * is enable starling engine 
		 */		
		private var _isStarling:Boolean = false;
		
		public function _Web_Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(doInitialize, 100);
		}
		
		protected function doInitialize():void
		{
			if(stage)	initialize()
			else 	addEventListener(Event.ADDED_TO_STAGE,initialize);
		}
		
		protected function initialize(e:Event = null):void
		{
			addManagers();
			
			MainMgr.instance.init(this, true );
			
			onInit();
			
			_isStarling = true;
			//use different display mode
			if( _isStarling )
			{
				Starling.handleLostContext = true;
				_starlingEngine = new Starling(game.starling.GameWorld, stage, new Rectangle(0,0,960,640),null,"auto","baseline");
				_starlingEngine.start();
			}
			else
			{
				new game.nostarling.GameWorld(stage);
			}
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
			MainMgr.instance.addMgr( MgrType.LAYER_MGR , new LayerMgr() );
			MainMgr.instance.addMgr( MgrType.DISPLAY3D_MGR , new Display3DMgr() );
			MainMgr.instance.addMgr( MgrType.LAYER3D_MGR , new Layer3DMgr() );
		}
		
		private function onInit():void
		{
			var tf:TextFormat = new TextFormat("宋体",14, 0xffffff);
			TextTool.addTextField(stage, "x=      y=", tf, null, 0 ,450,450);
			TextTool.addTextField(stage, "", tf, null, 0, 470, 450);
			TextTool.addTextField(stage, "", tf, null, 0, 490, 350);
			TextTool.addTextField(stage, "", tf, null, 0, 510, 350);
			TextTool.addTextField(stage, "v1.0.0操作说明：W上S下A左D右 J攻击", tf, null, 0, 430, 350);			
			TextTool.addTextField(stage, " ", tf, null, 0, 550, 350);			
		}
	}
}