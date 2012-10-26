package
{
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class GameWorld extends Sprite
	{
		public function GameWorld()
		{
			super();
			
			if(stage)
			{
				initialize();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
		}
		
		private function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.color = 0;
			
			Starling.current.showStats = true;
			Starling.current.antiAliasing = 0;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandle);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandle);
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			
			if(touch == null)
			{
				return;
			}
		}
		
		private function onMouseDown(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
		}
		
		
		private function onKeyUpEventHandle(e:KeyboardEvent):void
		{
			trace("onKeyUpEventHandle:", e.keyCode);
		}
		
		private function onKeyDownEventHandle(e:KeyboardEvent):void
		{
			
		}
	}
}