package common.core.layers.nostarling
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 游戏Avg层
	 * 
	 * 一些层的集合
	 * @author noah
	 */	
	public class LayerAvg extends Layer {
		/**
		 * 游戏后图层 
		 */		
		public static const BACK_IMG:uint = 0;
		/**
		 * 游戏中图层 
		 */		
		public static const MIDDLE_IMG:uint = 1;
		/**
		 * 游戏文本层 
		 */		
		public static const TEXT:uint = 2;
		/**
		 * 游戏前图层 
		 */		
		public static const FRONT_IMG:uint = 3;
		/**
		 * 游戏事件层 
		 */		
		public static const EVENT:uint = 4;
		/**
		 * 游戏界面层 
		 */		
		public static const UI:uint = 5;
		/**
		 * 游戏鼠标层 
		 */		
		public static const CURSER:uint = 6;
		
		public function LayerAvg()
		{
			super();
		}
			
		/**
		 * 将一个或多个元素添加到数组的结尾，并返回该数组的新长度。
		 * @param parameters
		 * @return 
		 */		
		override public function push( obj:DisplayObject):uint{
			return layerArr.push( obj );
		}
		
		public function get gameBackLevel():Sprite
		{
			return  layerArr[ LayerAvg.BACK_IMG ];
		}
		public function get gameMiddleLevel():Sprite
		{
			return  layerArr[ LayerAvg.MIDDLE_IMG ];
		}
		public function get gameTextLevel():Sprite
		{
			return  layerArr[ LayerAvg.TEXT ];
		}
		public function get gameFrontLevel():Sprite
		{
			return  layerArr[ LayerAvg.FRONT_IMG ];
		}
		public function get gameEventLevel():Sprite
		{
			return  layerArr[ LayerAvg.EVENT ];
		}
		public function get gameUiLevel():Sprite
		{
			return  layerArr[ LayerAvg.UI ];
		}
		public function get gameCurserLevel():Sprite
		{
			return  layerArr[ LayerAvg.CURSER ];
		}
	}
}