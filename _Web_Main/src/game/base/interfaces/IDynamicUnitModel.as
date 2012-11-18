package game.base.interfaces
{
	
	public interface IDynamicUnitModel extends IStaticUnitModel
	{
		function get speed():Number;
		function set speed( value:Number):void;
	}
}