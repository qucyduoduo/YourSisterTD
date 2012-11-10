package game.events
{
	import common.base.events.BaseEvent;
	
	public class SkillEvent extends BaseEvent
	{
		public static var SKILL_REMOVE:String = "skill_remove";
		
		public function SkillEvent(type:String, paramObject:Object=null)
		{
			super(type, paramObject);
		}
	}
}