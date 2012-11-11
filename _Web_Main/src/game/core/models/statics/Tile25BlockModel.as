package  game.core.models.statics
{
	import common.base.models.BaseModel;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.events.ModelEvent;
	import game.core.interfaces.IBlockModel;
	import game.core.interfaces.IStaticObjectModel;
	import game.core.interfaces.ITileObjectModel;
	import game.base.models.TileObjectModel;
	
	public class Tile25BlockModel extends BaseModel implements IBlockModel,ITileObjectModel,IStaticObjectModel
	{
		private var blockModel:TileBlockModel;
		
		public function Tile25BlockModel()
		{
			super();
			blockModel = new TileBlockModel();
		}
		public function get hitRect():Rectangle{
			return blockModel.hitRect;
		}
		public function set hitRect(value:Rectangle):void{
			blockModel.hitRect = value;
		}
		public function set num(value:uint):void{
			blockModel.num = value;
		}
		public function get num():uint{
			return blockModel.num;
		}
		public function set modX(value:Number):void{
			if(blockModel.modX != value){
				blockModel.modX = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get modX():Number{
			return blockModel.modX;
		}
		public function set modY(value:Number):void{
			if(blockModel.modY != value){
				blockModel.modY = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get modY():Number{
			return blockModel.modY;
		}
		public function get gridXs():Array{
			return blockModel.gridXs;
		}
		public function get gridYs():Array{
			return blockModel.gridYs;
		}
		public function get gridX():uint{
			return blockModel.gridX;
		}
		public function get gridY():uint{
			return blockModel.gridY;
		}
		public function set dir(value:uint):void{
			blockModel.dir = value;
			if(blockModel.dir != blockModel.oldDir){
				blockModel.oldDir = blockModel.dir;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get dir():uint{
			return blockModel.dir;
		}
		public function set oldDir(value:uint):void{
			blockModel.oldDir = value;
		}
		public function get oldDir():uint{
			return blockModel.oldDir;
		}
		public function get posX():Number{
			var ppp:Point = tileXY( new Point(blockModel.modX, blockModel.modY));
			return ppp.x + TileObjectModel.PADDING_LEFT;
		}
		public function get posY():Number{
			var ppp:Point = tileXY( new Point(blockModel.modX, blockModel.modY));
			return ppp.y;
		}
		public function tileXY( p:Point ):Point{
			return blockModel.tileXY( p );
		}
	}
}