package common.base.factory
{
	import common.base.interfaces.IFactory;

	/**
	 * 工厂类基类
	 * 
	 * 所有工厂类继承这个类
	 * @author noah
	 */	
	public class BaseFactory implements IFactory
	{
		
		public function BaseFactory()
		{
			
		}
		
		protected function newInstance( classNameStr:String ):*
		{
			
		}
	}
}