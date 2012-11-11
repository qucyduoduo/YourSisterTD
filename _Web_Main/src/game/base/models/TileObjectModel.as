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
		public function get hitRect():Rectangle{
			return objectModel.hitRect;
		}
		public function set hitRect(value:Rectangle):void{
			objectModel.hitRect = value;
		}
		public function set modX(value:Number):void{
			if(objectModel.modX != value){
				objectModel.modX = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get modX():Number{
			return objectModel.modX;
		}
		public function set modY(value:Number):void{
			if(objectModel.modY != value){
				objectModel.modY = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get modY():Number{
			return objectModel.modY;
		}
		public function get gridXs():Array{
			return objectModel.gridXs;
		}
		public function get gridYs():Array{
			return objectModel.gridYs;
		}
		public function get gridX():uint{
			return objectModel.gridX;
		}
		public function get gridY():uint{
			return objectModel.gridY;
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
		public function set oldDir(value:uint):void{
			objectModel.oldDir = value;
		}
		public function get oldDir():uint{
			return objectModel.oldDir;
		}
		public function get posX():Number{
			var ppp:Point = tileXY( new Point(objectModel.modX, objectModel.modY));
			return ppp.x + PADDING_LEFT;
		}
		public function get posY():Number{
			var ppp:Point = tileXY( new Point(objectModel.modX, objectModel.modY));
			return ppp.y;
		}
		public function tileXY( p:Point ):Point{
			return TileObjectModel.tileXY( p );
		}
		public static function tileXY( p:Point ):Point{
			var pp:Point;
			pp = p;
			//旋转
			pp = pointMatrix(p, Math.cos(R45), Math.sin(R45), -Math.sin(R45), Math.cos(R45));
			//拉升x
			pp = pointMatrix( pp, 1.4, 0, 0, 0.7);
			//平移
			//pp = pointMatrix(pp, 0, 0, (3 - Math.SQRT2) * MapModel.BLOCK_WIDTH >> 1, 0);
			return pp;
		}
		public static function pointMatrix(p:Point, a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):Point{
			
			var xx:Number = p.x * a + p.y * c;
			var yy:Number = p.x * b + p.y * d;
			return new Point(xx,yy);
		}
	}
}