package  game.base.models
{
	import flash.geom.Point;
	
	import game.base.interfaces.IStaticUnitModel;

	public class StaticUnitModel extends GameUnitModel implements IStaticUnitModel
	{
		public function StaticUnitModel()
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
		public function getPos():Point
		{
			return new Point( x, y);
		}
	}
}