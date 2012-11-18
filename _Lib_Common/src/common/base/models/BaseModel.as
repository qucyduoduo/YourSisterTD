package common.base.models
{
	import common.base.interfaces.IModel;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 模型类的基类
	 * 
	 * 所有模型类都必须继承这个类 
	 * @author noah
	 */	
	public class BaseModel extends EventDispatcher implements IModel
	{
		protected var _x:Number;
		protected var _y:Number;
		
		public function BaseModel()	
		{
		
		}
		public function get x():Number
		{
			return _x;	
		}
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		public function set y(value:Number):void
		{
			_y = value;
		}
		/**
		 * 
		 */		
		public function update():void
		{
			
		}
		
		public function dispose():void
		{
			
		}
	}
}