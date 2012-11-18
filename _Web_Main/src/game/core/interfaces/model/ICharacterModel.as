package game.core.interfaces.model
{
	import game.base.interfaces.IDynamicUnitModel;

	public interface ICharacterModel extends IDynamicUnitModel
	{
		function get isAniPlaying():Boolean;
		function set isAniPlaying(value:Boolean):void;
		function get isGCD():Boolean;
		function set isGCD(value:Boolean):void;
	}
}