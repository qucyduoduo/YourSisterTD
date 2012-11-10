package org.rpg.models
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import game.events.SkillEvent;
	import game.interfaces.IMapModel;
	import game.interfaces.ISkillBallModel;

	public class SkillBallModel extends DynamicObjectModel implements ISkillBallModel
	{
		public function SkillBallModel()
		{
			super();
		}
	}
}