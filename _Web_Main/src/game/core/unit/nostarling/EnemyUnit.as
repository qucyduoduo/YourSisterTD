package game.core.unit.nostarling
{
	import flash.display.MovieClip;
	
	public class EnemyUnit extends MapUint
	{
		public function EnemyUnit(animation:MovieClip, defaultState:String="all")
		{
			super(animation, defaultState);
		}
	}
}