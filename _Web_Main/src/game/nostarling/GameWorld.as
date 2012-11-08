package game.nostarling
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class GameWorld extends Sprite
	{
		private var _stage:Stage;
		
		public function GameWorld( stage:Stage )
		{
			super();
			_stage = stage;
			if(_stage)
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
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandle);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandle);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			
		}
		
		private function onTouch(e:MouseEvent):void
		{
			trace("onMouseEventHandle:", e);
		}
		
		private function onKeyUpEventHandle(e:KeyboardEvent):void
		{
			trace("onKeyUpEventHandle:", e.keyCode);
		}
		
		private function onKeyDownEventHandle(e:KeyboardEvent):void
		{
			trace("onKeyDownEventHandle:", e.keyCode);
		}
	}
}