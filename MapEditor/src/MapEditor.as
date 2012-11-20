package
{
	import com.bit101.components.Style;
	
	import data.MapData;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import panel.ControlsPanel;
	import panel.MapPanel;
	
	[SWF(width="800", height="405", frameRate="30",backgroundColor="0x000000")]
	public class MapEditor extends Sprite
	{
		private var _currentFile:File;
		private var _mapData:MapData;
		private var _saveCount:int;
		private var _controlsPanel:ControlsPanel;
		private var _mapPanel:MapPanel;
		
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
		
		private function initialize():void
		{
			Style.fontName = "arial";
			Style.embedFonts = false;
			Style.fontSize = 12;
			Style.setStyle(Style.LIGHT);
			
			initMenus();
			initPanels();
			initPanelsEvent();
			
			stage.nativeWindow.addEventListener(Event.RESIZE, onResizeHandle);
		}
		
		private function initMenus():void
		{
			var editorMenu:MainMenu = new MainMenu();
			editorMenu.addEventListener( "new", menuEventHandler);
			editorMenu.addEventListener( "open", menuEventHandler);
			editorMenu.addEventListener( "save", menuEventHandler);
			stage.nativeWindow..menu = editorMenu;
		}
		
		private function initPanels():void
		{
			_controlsPanel = new ControlsPanel( this, 0, 0 );
			_mapPanel = new MapPanel( this, 0, 0 );
			onResizeHandle();
		}
		
		private function onResizeHandle(e:NativeWindowBoundsEvent = null):void
		{
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			_controlsPanel.setSize( 180, stage.stageHeight );
			_mapPanel.x = 220;
			_mapPanel.setSize( 960 * 0.6, 640 * 0.6 );
			trace( stage.stageWidth, stage.stageHeight );
		}
		
		private function initPanelsEvent():void
		{
			_controlsPanel.addEventListener( "addWalk" , onAddWalkHandler );	
			_controlsPanel.addEventListener( "addBlock" , onAddBlockHandler );	
		}
		
		private function onAddBlockHandler(e:Event):void
		{
			_mapPanel.addType = 1;
		}
		
		private function onAddWalkHandler(e:Event):void
		{
			_mapPanel.addType = 0;
		}
		
		private function menuEventHandler(e:Event):void
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
		/**
		 * 新建地图
		 */		
		private function onNewHandler():void
		{
			_mapData = new MapData();
			var bytes:ByteArray = _mapData.toByteArray();
			_currentFile = new File();
			_currentFile.addEventListener(Event.COMPLETE, onSaved ,false,0,true);
			_currentFile.save( bytes, "未命名_"+ _saveCount++ + ".map");
		}
		/**
		 *打开地图 
		 */		
		private function onOpenHandler():void
		{
			_currentFile = new File();
			_currentFile.addEventListener(Event.SELECT, onOpened,false,0, true);
			_currentFile.browseForOpen("打开文件",[new FileFilter("地图文件","*.map")]);
		}
		/**
		 * 保存地图
		 */		
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
		/**
		 * 读取打开的地图
		 */		
		private function onOpened(e:Event):void
		{
			var fs:FileStream = new FileStream();
			fs.open(_currentFile, FileMode.READ);
			
			var data:ByteArray = new ByteArray();
			fs.position = 0;
			fs.readBytes(data);
			_mapData = new MapData();
			_mapData.fromByteArray( data );
			
			_mapPanel.setData( _mapData );
		}
		/**
		 * 刷新地图视图
		 */		
		private function onSaved(e:Event):void
		{
			_mapPanel.setData( _mapData );
		}
	}
}