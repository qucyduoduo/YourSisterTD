package  game.models.statics
{
	import game.interfaces.IBlockModel;
	import game.interfaces.IStaticObjectModel;

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