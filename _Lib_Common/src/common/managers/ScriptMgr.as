package common.managers
{
	import common.base.interfaces.IMgr;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 脚本管理器
	 * @author noah
	 */
	public class ScriptMgr implements IMgr
	{
		/**
		 * 
		 */		
		private var _dataLoader:URLLoader;
		/**
		 * 
		 */		
		private var _dataObj:Object;
		private var _isDisposed:Boolean;
		/**
		 * 构造函数
		 */		
		public function ScriptMgr()	
		{
		
		}
		/**
		 * 
		 */		
		public function init():void
		{
			_dataLoader = new URLLoader();
			_dataLoader.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			_dataLoader.load(new URLRequest("json/test.json"));
		}
		/**
		 * 
		 * @param e
		 */		
		private function onLoadCompleteHandler(e:Event):void 
		{
			_dataObj = JSON.parse(_dataLoader.data);
			var dataArr:Array = _dataObj["data"];
			var steps:Object = _dataObj["steps"];
			
			for each(var data:Object in dataArr)
			{
				var param:Object = data[1];
				var str:String = "[" + data[0];
				for (var att:String in param)
				{
					str += " " + att + "=\"" + param[att] + "\"";
				}
				str += "]";
				trace( str );
			}
		}
		
		public function dispose():void
		{
			if(_isDisposed == false)
			{
				distruct();
				_isDisposed = true;
			}
		}
		
		protected function distruct():void
		{
			//TODO dispose resource table.
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}