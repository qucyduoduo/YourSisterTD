package game.core.interfaces.model
{
	import game.base.interfaces.IGameUnitModel;

	public interface IMapModel extends IGameUnitModel
	{
		function get dataList():Vector.<int>;
	}
}