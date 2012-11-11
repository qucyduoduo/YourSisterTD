package game.core.interfaces
{
	import flash.geom.Point;
	
	
	public interface ITileObjectModel extends IObjectModel
	{
		function tileXY( p:Point ):Point;
		//function pointMatrix(p:Point, a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):Point;
	}
}