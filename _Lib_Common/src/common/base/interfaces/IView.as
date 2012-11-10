package common.base.interfaces
{
	/**
	 * 视图接口
	 * 
	 * 所有视图类的父类都必须实现这个接口
	 * @author noah
	 */	
	public interface IView
	{
		function setup():void;
		function init(data:Object=null):void;
		function show():void;
		function hide():void;
		function destroy():void;
	}
}