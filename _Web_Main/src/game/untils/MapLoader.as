package game.untils
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class MapLoader
	{
		private static var mapJsonLoader:URLLoader;
		private static var _callBack:Function;
		
		public function MapLoader()
		{
			
		}
		
		private static function onMapJsonLoadCompleteHandler(e:Event):void{
			mapJsonLoader.removeEventListener("complete", onMapJsonLoadCompleteHandler);
			
			_callBack( JSON.parse(mapJsonLoader.data) );
		}
		
		public static function load( callBack:Function):void
		{
			_callBack = callBack;
			mapJsonLoader = new URLLoader();
			mapJsonLoader.addEventListener("complete", onMapJsonLoadCompleteHandler);
			mapJsonLoader.load(new URLRequest("data/map.json"));
		}
	}
}