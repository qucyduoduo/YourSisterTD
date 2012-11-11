package  game.core.models.statics
{
	import game.core.interfaces.IBlockModel;
	import game.core.interfaces.IStaticObjectModel;

	/**
	 * 地图单元模型
	 * @author noah
	 */	
	public class BlockModel extends StaticObjectModel implements IBlockModel,IStaticObjectModel
	{
		public function BlockModel()
		{
			super();
		}
	}
}