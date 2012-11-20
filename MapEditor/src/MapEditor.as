package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.setTimeout;
	
	[SWF(width="960", height="640", frameRate="30",backgroundColor="0x000000")]
	public class MapEditor extends Sprite
	{
		private var _currentFile:File;
		private var _mapData:MapData;
		private var _saveCount:int;
		
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
			var bytes:ByteArray = _mapData.toByteArray();
			var fs:FileStream = new FileStream();
			fs.open(_currentFile, FileMode.WRITE);
			fs.position = 0;
			fs.truncate();
			fs.writeBytes( bytes );
			fs.close();
		}
		
		private function onOpenHandler():void
		{
			_currentFile = new File();
			_currentFile.addEventListener(Event.SELECT, onOpened,false,0, true);
			_currentFile.browseForOpen("打开文件",[new FileFilter("地图文件","*.map")]);
		}
		
		private function onNewHandler():void
		{
			_mapData = new MapData();
			var bytes:ByteArray = _mapData.toByteArray();
			_currentFile = new File();
			_currentFile.addEventListener(Event.COMPLETE, onSaved ,false,0,true);
			_currentFile.save( bytes, "未命名_"+ _saveCount++ + ".map");
		}
		
		protected function onOpened(e:Event):void
		{
			var fs:FileStream = new FileStream();
			fs.open(_currentFile, FileMode.READ);
			
			var data:ByteArray = new ByteArray();
			fs.position = 0;
			fs.readBytes(data);
			_mapData = new MapData();
			_mapData.fromByteArray( data );
		}
		
		protected function onSaved(e:Event):void
		{
			
		}
	}
}