package common.base.interfaces
{
	/**
	 * 控制器接口
	 * 
	 * 所有控制器的父类都必须实现这个接口
	 * @author noah
	 */	
	public interface IController
	{
		function init( model:IModel ):void;
	}
}