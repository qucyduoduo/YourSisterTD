package  game.core.interfaces.view
{
	import starling.display.Image;
	import starling.display.Sprite;
	import game.base.interfaces.IGameUnitView;
	
	public interface IMapView extends IGameUnitView
	{
		function get groundLevel():Image;
		function get contentLevel():Sprite;
		function get airLevel():Sprite;
	}
}