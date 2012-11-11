package game.core.models
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import common.base.models.BaseModel;
	import game.core.events.ModelEvent;
	import game.core.events.SkillEvent;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.ISkillBallModel;
	import game.core.interfaces.ITileObjectModel;
	import org.rpg.models.MapModel;
	import game.core.models.SkillBallModel;
	
	public class TileSkillBallModel extends BaseModel implements ISkillBallModel,ITileObjectModel
	{
		private var skillBallModel:SkillBallModel;
		
		public function get hitRect():Rectangle{
			return skillBallModel.hitRect;
		}
		public function set hitRect(value:Rectangle):void{
			skillBallModel.hitRect = value;
		}
		public function get oldModX():Number{
			return skillBallModel.oldModX;
		}
		public function set oldModX(value:Number):void{
			skillBallModel.oldModX = value;
		}
		public function get oldModY():Number{
			return skillBallModel.oldModY;
		}
		public function set oldModY(value:Number):void{
			skillBallModel.oldModY = value;
		}
		public function get speed():Number{
			return skillBallModel.speed;
		}
		public function set speed(value:Number):void{
			skillBallModel.speed = value;
		}	
		public function get posX():Number{
			var ppp:Point = tileXY( new Point(skillBallModel.modX, skillBallModel.modY));
			return ppp.x + TileObjectModel.PADDING_LEFT + MapModel.TILE_BLOCK_WIDTH;
		}
		public function get posY():Number{
			var ppp:Point = tileXY( new Point(skillBallModel.modX, skillBallModel.modY));
			return ppp.y;
		}
		
		public function TileSkillBallModel()
		{
			super();
			skillBallModel = new SkillBallModel();
			skillBallModel.addEventListener(ModelEvent.UPDATE, onUpdateHanlder);
		}
		
		protected function onUpdateHanlder(event:Event):void
		{
			dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
		}
		
		public function getPos(type:uint):Point{
			
			return skillBallModel.getPos(type);
		}
		
		/**
		 * 
		 */		
		public function move( mapModel:IMapModel ):void
		{
			skillBallModel.move( mapModel );
		}
		public function set modX(value:Number):void{
			skillBallModel.modX = value;
		}
		public function get modX():Number{
			return skillBallModel.modX;
		}
		public function set modY(value:Number):void{
			skillBallModel.modY = value;
		}
		public function get modY():Number{
			return skillBallModel.modY;
		}
		public function get gridXs():Array{
			return skillBallModel.gridXs;
		}
		public function get gridYs():Array{
			return skillBallModel.gridYs;
		}
		public function get gridX():uint{
			return skillBallModel.gridX;
		}
		public function get gridY():uint{
			return skillBallModel.gridY;
		}
		public function set dir(value:uint):void{
			skillBallModel.dir = value;
		}
		public function get dir():uint{
			return skillBallModel.dir;
		}
		public function tileXY( p:Point ):Point{
			var pp:Point;
			pp = p;
			//旋转
			pp = pointMatrix(p, Math.cos(TileObjectModel.R45), Math.sin(TileObjectModel.R45), -Math.sin(TileObjectModel.R45), Math.cos(TileObjectModel.R45));
			//拉升x
			pp = pointMatrix( pp, 2.8, 0, 0, 1.4);
			//平移
			//pp = pointMatrix(pp, 0, 0, (3 - Math.SQRT2) * peopleModel.BLOCK_WIDTH >> 1, 0);
			return pp;
		}
		public function pointMatrix(p:Point, a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0):Point{
			
			var xx:Number = p.x * a + p.y * c;
			var yy:Number = p.x * b + p.y * d;
			return new Point(xx,yy);
		}
	}
}