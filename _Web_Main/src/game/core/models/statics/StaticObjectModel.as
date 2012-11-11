package  game.core.models.statics
{
	import flash.geom.Point;
	
	import game.core.interfaces.IStaticObjectModel;
	import game.base.models.ObjectModel;

	public class StaticObjectModel extends ObjectModel implements IStaticObjectModel
	{
		public function StaticObjectModel()
		{
			super();
		}
		
		/**
		 * 获取模型在视图中的绝对坐标
		 * @param type 
		 * 1 = 平面 
		 * 2 = 45度视角
		 * @return 
		 */		
		public function getPos(type:uint):Point{
			
			if(type == 1){
				modX = ( gridX + 1) * MapModel.BLOCK_WIDTH - (MapModel.BLOCK_WIDTH >> 1);
				modY = ( gridY + 1) * MapModel.BLOCK_WIDTH - (MapModel.BLOCK_WIDTH >> 1);
				return new Point( modX, modY);
			} else {
				modX = ( gridX + 1) * MapModel.BLOCK_WIDTH - (MapModel.BLOCK_WIDTH >> 1);
				modY = ( gridY + 1) * MapModel.BLOCK_WIDTH - (MapModel.BLOCK_WIDTH >> 1);
				return new Point( modX, modY);
			}
		}
	}
}