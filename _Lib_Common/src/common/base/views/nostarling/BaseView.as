package common.base.views.nostarling
{
	import common.base.interfaces.IView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
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
		/**
		 * 
		 * @param e
		 */		
		protected function onClickHandler(e:MouseEvent):void
		{
		}
	}
}