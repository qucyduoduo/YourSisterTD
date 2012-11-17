package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import game.core.managers.MainMgr;
	
	[SWF(width="960", height="640", frameRate="60",backgroundColor="0x000000")]
	public class _Web_Main extends Sprite
	{
		public function _Web_Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(doInitialize, 100);
		}
		
		protected function doInitialize():void
		{
			if(stage) initialize()
			else 	addEventListener(Event.ADDED_TO_STAGE,initialize);
		}
		
		protected function initialize(e:Event = null):void
		{
			MainMgr.instance.init(this, true );
		}
	}
}