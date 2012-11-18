package common.base.views.nostarling
{
	import common.base.interfaces.IView;
	
	import flash.display.Sprite;
	
	/**
	 * 视图类的基类
	 * 
	 * 所有视图类都必须继承这个类 
	 * @author noah
	 */	
	public class BaseView extends Sprite implements IView 
	{
		/**
		 * 构造函数
		 */		
		public function BaseView()
		{
		
		}
		/**
		 * 填充数据到视图
		 * @param data
		 */		
		public function init():void
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