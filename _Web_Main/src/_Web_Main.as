package
{
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	[SWF(width="960", height="640", frameRate="60")]
	public class _Web_Main extends Sprite
	{
		private var _starlingEngine:Starling;
		
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
			Style.fontName = "arial";
			Style.embedFonts = false;
			Style.fontSize = 12;
			Style.setStyle(Style.DARK);
			
			Starling.handleLostContext = true;
			
			_starlingEngine = new Starling(GameWorld, stage, new Rectangle(0,0,960,640),null,"auto","baseline");
			_starlingEngine.start();
		}
	}
}