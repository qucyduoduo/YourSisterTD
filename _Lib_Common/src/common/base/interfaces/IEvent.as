package common.base.interfaces
{
	/**
	 * 事件接口
	 * 
	 * 所有事件类的父类都必须实现这个接口
	 * @author noah
	 */	
	public interface IEvent 
	{
		function get paramObject():Object;
	}
}