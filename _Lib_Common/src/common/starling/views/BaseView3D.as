package common.starling.views
{
	import common.base.interfaces.IView;
	import common.managers.MainMgr;
	
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
		public function setup():void{
			MainMgr.instance.classTrace( "setup", this );
		}
		/**
		 * 填充数据到视图
		 * @param data
		 */		
		public function init(data:Object=null):void{
			MainMgr.instance.classTrace( "init", this );
		}
		/**
		 * 显示视图
		 */		
		public function show():void{
			MainMgr.instance.classTrace( "show", this );
		}
		/**
		 * 更新视图
		 */		
		public function update():void{
			MainMgr.instance.classTrace( "update", this );
		}
		/**
		 * 隐藏视图
		 */		
		public function hide():void{
			MainMgr.instance.classTrace( "hide", this );
		}
		/**
		 * 销毁视图
		 */		
		public function destroy():void{
			MainMgr.instance.classTrace( "destroy", this );
		}
	}
}