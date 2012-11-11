package  game.core.models.dynamics
{
	import common.base.models.BaseModel;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IDynamicObjectModel;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IPeopleModel;
	import game.core.interfaces.ITileObjectModel;
	import game.app.managers.BattleMgr;
	import game.base.models.TileObjectModel;
	import game.core.models.statics.MapModel;

	
	public class TilePeopleModel extends BaseModel implements IPeopleModel,IDynamicObjectModel,ITileObjectModel
	{
		private var peopleModel:PeopleModel;
		
		public function get hitRect():Rectangle{
			return peopleModel.hitRect;
		}
		public function set hitRect(value:Rectangle):void{
			peopleModel.hitRect = value;
		}
		public function set isAniPlaying(value:Boolean):void{
			peopleModel.isAniPlaying = value;
		}
		public function get isAniPlaying():Boolean{
			return peopleModel.isAniPlaying;
		}
		
		public function get isGCD():Boolean{
			return peopleModel.isGCD;
		}
		public function set isGCD(value:Boolean):void{
			peopleModel.isGCD = value;
		}
		
		public function get oldModX():Number{
			return peopleModel.oldModX;
		}
		public function set oldModX(value:Number):void{
			peopleModel.oldModX = value;
		}
		public function get oldModY():Number{
			return peopleModel.oldModY;
		}
		public function set oldModY(value:Number):void{
			peopleModel.oldModY = value;
		}
		public function get speed():Number{
			return peopleModel.speed;
		}
		public function set speed(value:Number):void{
			peopleModel.speed = value;
		}	
		public function get currentDir():uint{
			return peopleModel.currentDir;
		}
		public function set currentDir(value:uint):void{
			peopleModel.currentDir = value;
		}	
		public function get posX():Number{
			var ppp:Point = tileXY( new Point(peopleModel.modX, peopleModel.modY));
			return ppp.x + TileObjectModel.PADDING_LEFT + MapModel.TILE_BLOCK_WIDTH;
		}
		public function get posY():Number{
			var ppp:Point = tileXY( new Point(peopleModel.modX, peopleModel.modY));
			return ppp.y;
		}
		public function heated( model:* ):void{
			peopleModel.heated( model );
		}

		public function TilePeopleModel()
		{
			super();
			peopleModel = new PeopleModel();
			peopleModel.addEventListener(ModelEvent.UPDATE, onUpdateHanlder);
		}
		
		protected function onUpdateHanlder(event:Event):void
		{
			dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
		}		
		/**
		 * 获取模型在视图中的绝对坐标
		 * @param type 
		 * 1 = 平面 
		 * 2 = 45度视角
		 * @return 
		 */		
		public function getPos(type:uint):Point{
			
			return peopleModel.getPos(type);
		}
		/**
		 * 攻击
		 * @param map
		 */		
		public function attack(map:IMapView):void
		{
			BattleMgr.instance.attack( this, map );
			dispatchEvent(new ActionEvent( ActionEvent.ATTACK, map ));
		}
		/**
		 * 远程攻击
		 * @param map
		 */		
		public function cast(map:IMapView):void
		{
			BattleMgr.instance.cast( this, map );
			dispatchEvent(new ActionEvent( ActionEvent.ATTACK, map ));
		}
		/**
		 * 
		 */		
		public function move( model:IMapModel ):void
		{
			peopleModel.move( model );
		}
		
		public function set modX(value:Number):void{
			peopleModel.modX = value;
		}
		public function get modX():Number{
			return peopleModel.modX;
		}
		public function set modY(value:Number):void{
			peopleModel.modY = value;
		}
		public function get modY():Number{
			return peopleModel.modY;
		}
		public function get gridXs():Array{
			return peopleModel.gridXs;
		}
		public function get gridYs():Array{
			return peopleModel.gridYs;
		}
		public function get gridX():uint{
			return peopleModel.gridX;
		}
		public function get gridY():uint{
			return peopleModel.gridY;
		}
		public function set dir(value:uint):void{
			peopleModel.dir = value;
		}
		public function get dir():uint{
			return peopleModel.dir;
		}
		public function set oldDir(value:uint):void{
			peopleModel.oldDir = value;
		}
		public function get oldDir():uint{
			return peopleModel.oldDir;
		}
		public function tileXY( p:Point ):Point{
			return TileObjectModel.tileXY( p );
		}
	}
}