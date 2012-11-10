package common.utils 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class UILoader
	{
		private static var _loader:Loader;
		private static var _callBack:Function;
		
		public function UILoader()
		{
		}
		
		public static function load( callBack:Function ):void{
			_callBack = callBack;
			_loader = new  Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadUICompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFailLoadUIHandler);
			_loader.load(new URLRequest("GCoreUI.swf"));
		}
		
		
		protected static function onLoadUICompleteHandler(event:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadUICompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onFailLoadUIHandler);			
			_callBack( _loader );
		}
		protected static function onFailLoadUIHandler(event:IOErrorEvent):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadUICompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onFailLoadUIHandler);			
		}
	}
}