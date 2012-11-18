package common.base.interfaces
{
	/**
	 * 模型接口
	 * 
	 * 所有模型类的父类都必须实现这个接口
	 * @author noah
	 */	
	public interface IModel
	{
		function update():void;
		function dispose():void;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
	}
}