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
		/**
		 * 
		 */		
		public function BaseModel()	
		{
		
		}
		/**
		 * 
		 */		
		public function update():void
		{
			
		}
	}
}