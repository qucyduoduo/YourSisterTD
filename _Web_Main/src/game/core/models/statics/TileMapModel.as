package  game.core.models.statics
{
	import common.base.models.BaseModel;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IStaticObjectModel;
	import game.core.interfaces.ITileObjectModel;
	import game.base.models.TileObjectModel;

	public class TileMapModel extends BaseModel// implements IMapModel,ITileObjectModel,IStaticObjectModel
	{
//		private var mapModel:MapModel;
//		
//		public function get dataArr():Array{
//			return mapModel.dataArr;
//		}
//		public function set dataArr(value:Array):void{
//			mapModel.dataArr = value;
//		}
//		
//		public function TileMapModel(data:Object)
//		{
//			super();
//			mapModel = new MapModel(data);
//		}
//		
//		public function get hitRect():Rectangle{
//			return mapModel.hitRect;
//		}
//		public function set hitRect(value:Rectangle):void{
//			mapModel.hitRect = value;
//		}
//		public function set modX(value:Number):void{
//			if(mapModel.modX != value){
//				mapModel.modX = value;
//				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
//			}
//		}
//		public function get modX():Number{
//			return mapModel.modX;
//		}
//		public function set modY(value:Number):void{
//			if(mapModel.modY != value){
//				mapModel.modY = value;
//				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
//			}
//		}
//		public function get modY():Number{
//			return mapModel.modY;
//		}
//		public function get gridXs():Array{
//			return mapModel.gridXs;
//		}
//		public function get gridYs():Array{
//			return mapModel.gridYs;
//		}
//		public function get gridX():uint{
//			return mapModel.gridX;
//		}
//		public function get gridY():uint{
//			return mapModel.gridY;
//		}
//		public function set dir(value:uint):void{
//			mapModel.dir = value;
//			if(mapModel.dir != mapModel.oldDir){
//				mapModel.oldDir = mapModel.dir;
//				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
//			}
//		}
//		public function get dir():uint{
//			return mapModel.dir;
//		}
//		public function set oldDir(value:uint):void{
//			mapModel.oldDir = value;
//		}
//		public function get oldDir():uint{
//			return mapModel.oldDir;
//		}
//		public function get posX():Number{
//			var ppp:Point = tileXY( new Point(mapModel.modX, mapModel.modY));
//			return ppp.x + TileObjectModel.PADDING_LEFT;
//		}
//		public function get posY():Number{
//			var ppp:Point = tileXY( new Point(mapModel.modX, mapModel.modY));
//			return ppp.y;
//		}
//		public function tileXY( p:Point ):Point{
//			return TileObjectModel.tileXY( p );
//		}
//		public function onHitTestGrid(model:*):Boolean{
//			return mapModel.onHitTestGrid(model);
//		}
	}
}