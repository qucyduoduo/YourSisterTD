package  game.base.models
{
	import common.base.models.BaseModel;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.events.ModelEvent;
	import game.core.interfaces.IObjectModel;
	import game.core.interfaces.ITileObjectModel;

	/**
	 * 斜45度物体模型
	 * @author noah
	 */	
	public class TileObjectModel extends BaseModel implements IObjectModel,ITileObjectModel
	{
		public static const PADDING_LEFT:Number = 350;
		public static const R45:Number = Math.PI / 180 * 45;
		private var objectModel:ObjectModel;
		
		public function TileObjectModel()
		{
			super();
			objectModel = new ObjectModel();
		}
		public function set x(value:Number):void{
			if(objectModel.x != value){
				objectModel.x = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get x():Number{
			return objectModel.x;
		}
		public function set y(value:Number):void{
			if(objectModel.y != value){
				objectModel.y = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get y():Number{
			return objectModel.y;
		}
		public function set dir(value:uint):void{
			objectModel.dir = value;
			if(objectModel.dir != objectModel.oldDir){
				objectModel.oldDir = objectModel.dir;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get dir():uint{
			return objectModel.dir;
		}
		public function get posX():Number{
			var ppp:Point = tileXY( new Point(objectModel.modX, objectModel.modY));
			return ppp.x + PADDING_LEFT;
		}
		public function get posY():Number{
			var ppp:Point = tileXY( new Point(objectModel.modX, objectModel.modY));
			return ppp.y;
		}
//		public static function tileXY( p:Point ):Point
//		{
//			var pp:Point;
//			pp = p;
//			//旋转
//			pp = pointMatrix(p, Math.cos(R45), Math.sin(R45), -Math.sin(R45), Math.cos(R45));
//			//拉升x
//			pp = pointMatrix( pp, 1.4, 0, 0, 0.7);
//			//平移
//			//pp = pointMatrix(pp, 0, 0, (3 - Math.SQRT2) * MapModel.BLOCK_WIDTH >> 1, 0);
//			return pp;
//		}
//		public static function pointMatrix(p:Point, a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):Point
//		{
//			var xx:Number = p.x * a + p.y * c;
//			var yy:Number = p.x * b + p.y * d;
//			return new Point(xx,yy);
//		}
	}
}