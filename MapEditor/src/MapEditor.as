package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class MapEditor extends Sprite
	{
		public function MapEditor()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			setTimeout(doInitialize, 100);
		}
		
		private function doInitialize():void
		{
			if(stage) initialize();
			else addEventListener(Event.ADDED_TO_STAGE,initialize);
		}
		
		protected function initialize():void
		{
			initMenus();
		}
		
		private function initMenus():void
		{
			var editorMenu:MainMenu = new MainMenu();
			editorMenu.addEventListener( "new", menuEventHandler);
			editorMenu.addEventListener( "open", menuEventHandler);
			editorMenu.addEventListener( "save", menuEventHandler);
			stage.nativeWindow..menu = editorMenu;
		}
		
		protected function menuEventHandler(e:Event):void
		{
			switch(e.type)
			{
				case "new":
				{
					onNewHandler();
					break;
				}
				case "open":
				{
					onOpenHandler();
					break;
				}
				case "save":
				{
					onSaveHandler();
					break;
				}
			}
		}
		
		private function onSaveHandler():void
		{
			
		}
		
		private function onOpenHandler():void
		{
			
		}
		
		private function onNewHandler():void
		{
			
		}
	}
}