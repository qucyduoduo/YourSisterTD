package common.starling.views
{
	import common.base.interfaces.IView;
	
	import starling.display.Sprite;
	
	/**
	 * 视图类的基类
	 * 
	 * 所有视图类都必须继承这个类 
	 * @author noah
	 */	
	public class BaseView3D extends Sprite implements IView 
	{
		/**
		 * 构造函数
		 */		
		public function BaseView3D(){
		}
		/**
		 * 设置视图
		 */		
		public function setup():void
		{
		}
		/**
		 * 填充数据到视图
		 * @param data
		 */		
		public function init(data:Object=null):void
		{
		}
		/**
		 * 显示视图
		 */		
		public function show():void
		{
		}
		/**
		 * 更新视图
		 */		
		public function update():void
		{
		}
		/**
		 * 隐藏视图
		 */		
		public function hide():void
		{
		}
		/**
		 * 销毁视图
		 */		
		public function destroy():void
		{
		}
	}
}