package game.core.models
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import game.core.events.SkillEvent;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.ISkillBallModel;

	public class SkillBallModel extends DynamicObjectModel implements ISkillBallModel
	{
		public function SkillBallModel()
		{
			super();
		}
	}
}