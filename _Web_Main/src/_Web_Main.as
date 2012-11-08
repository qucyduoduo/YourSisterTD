package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import game.nostarling.GameWorld;
	import game.starling.GameWorld;
	
	import starling.core.Starling;
	
	[SWF(width="960", height="640", frameRate="60")]
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
	}
}