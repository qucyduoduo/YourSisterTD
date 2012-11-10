package common.base.controllers
{
	import common.base.interfaces.IController;
	
	/**
	 * 控制类的基类
	 * 
	 * 所有控制类都必须继承这个类 
	 * @author noah
	 */	
	public class BaseController implements IController
	{
		public function BaseController()
		{

		}
		
		public function init( dataObj:Object ):void
		{
			
		}
	}
}