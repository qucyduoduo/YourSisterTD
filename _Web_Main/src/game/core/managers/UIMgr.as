package game.core.managers
{
	import common.base.interfaces.IMgr;
	import common.utils.Utils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.media.Sound;

	/**
	 * 
	 * @author noah
	 */
	public class UIMgr implements IMgr
	{
		/**
		 * 
		 */		
		private static var _loader:Loader;
		private var _isDisposed:Boolean;
		
		/**
		 * 构造函数
		 */		
		public function UIMgr()	
		{
			
		}
		/**
		 * 初始化
		 */		
		public function init( loader:Loader ):void
		{
			_loader = loader;
		}
		
		/**
		 * 获取加载器 
		 * @return 
		 */		
		public static function get loader():Loader{
			return _loader;
		}
		/**
		 * 获取某个类
		 * @param str
		 * @return 
		 */		
		public static function getClass(str:String):Class{
			return Utils.getClassFromLoader(str,_loader);
		}
		/**
		 * 获取UI库中的不确定类型的元件
		 * @param str 元件的链接名
		 * @return
		 */		
		public static function getDisplayObject(str:String):DisplayObject{
			return Utils.getDisplayObjectFromLoader(str,_loader);
		}
		/**
		 * 获取UI库中的MC
		 * @param str MC的链接名
		 * @return
		 */		
		public static function getMovieClip(str:String):MovieClip{
			return Utils.getMovieClipFromLoader(str,_loader);
		}
		/**
		 * 获取UI库中的sprite 
		 * @param str
		 * @return 
		 */		
		public static function getSprite(str:String):Sprite	{
			return Utils.getSpriteFromLoader(str,_loader);
		}
		/**
		 * 获取UI库中的按钮
		 * @param str 按钮的链接名
		 * @return 
		 */		
		public static function getButton(str:String):SimpleButton{
			return Utils.getSimpleButtonFromLoader(str,_loader);
		}
		/**
		 * 获取UI库中的图片
		 * @param str 图片的链接名
		 * @return
		 */		
		public static function getBitmap(str:String):Bitmap	{
			return new Bitmap(Utils.getBitmapDataFromLoader(str,_loader,true));
		}
		/**
		 * 获取UI库中的图片BitmapData
		 * @param str 图片的链接名
		 * @return
		 */		
		public static function getBitmapData(str:String):BitmapData	{
			return Utils.getBitmapDataFromLoader(str,_loader,true);
		}
		/**
		 * 获取UI库中的音乐文件
		 * @param str 音乐文件的链接名
		 * @return
		 */		
		public static function getSound(str:String):Sound{
			return Utils.getSoundFromLoader(str,_loader);
		}
		
		/**
		 * UI库中是否有指定的类名 
		 * @param name
		 * @return 
		 */		
		public static function hasDefinition(name:String):Boolean{
			return _loader.contentLoaderInfo.applicationDomain.hasDefinition(name);
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