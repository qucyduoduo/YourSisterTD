package  game.core.models.statics
{
	import game.core.interfaces.model.IBlockModel;
	import game.base.interfaces.IStaticUnitModel;
	import game.base.models.StaticUnitModel;

	/**
	 * 地图单元模型
	 * @author noah
	 */	
	public class BlockModel extends StaticUnitModel implements IBlockModel,IStaticUnitModel
	{
		public function BlockModel()
		{
			super();
		}
	}
}