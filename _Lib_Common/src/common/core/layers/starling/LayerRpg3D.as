package common.core.layers.starling
{
	import common.core.layers.nostarling.LayerRpg;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	/**
	 * 游戏Rpg层
	 * 
	 * 一些层的集合
	 * @author noah
	 */	
	public class LayerRpg3D extends Layer3D
	{
		/**
		 * 游戏地图背景层 
		 */		
		public static const MAP_BACK:uint = 0;
		/**
		 * 游戏地图前景层 
		 */		
		public static const MAP_FRONT:uint = 1;
		/**
		 * 游戏地图事件层 
		 */		
		public static const MAP_EVENT:uint = 2;
		/**
		 * 游戏地图人物层 
		 */		
		public static const MAP_PEOPLE:uint = 3;
		/**
		 * 游戏地图顶层 
		 */		
		public static const MAP_TOP:uint = 4;
		/**
		 * 游戏地图寻路层 
		 */		
		public static const MAP_PATH:uint = 5;
		
		public function LayerRpg3D(){
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
		
		public function get gameMapBackLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_BACK ];
		}
		public function get gameMapFrontLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_FRONT ];
		}
		public function get gameMapEventLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_EVENT ];
		}
		public function get gameMapPeopleLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_PEOPLE ];
		}
		public function get gameMapPathLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_PATH ];
		}
		public function get gameMapTopLevel():Sprite{
			
			return layerArr[ LayerRpg.MAP_TOP ];
		}
	}
}