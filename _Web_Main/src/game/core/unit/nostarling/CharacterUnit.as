package game.core.unit.nostarling
{
	import flash.display.MovieClip;
	
	public class CharacterUnit extends MapUint
	{
		public function CharacterUnit(animation:MovieClip, defaultState:String="all")
		{
			super(animation, defaultState);
		}
	}
}