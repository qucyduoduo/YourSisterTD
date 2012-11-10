package game.starling
{
	import common.starling.views.BaseView3D;
	import common.utils.MgrObjects;
	
	import game.interfaces.IMapView;
	import game.managers.KeyBoardMgr;
	import game.managers.TextureMgr;
	import game.starling.view.MapView3D;
	import game.starling.view.MonsterView3D;
	import game.starling.view.PeopleView3D;
	import game.starling.view.Tile25MapView3D;
	import game.starling.view.TileMapView3D;
	import game.starling.view.TileMonsterView3D;
	import game.starling.view.TilePeopleView3D;
	import game.untils.MapLoader;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameWorld extends Sprite
	{
		private var p:PeopleView3D;
		private var monster:MonsterView3D;
		private var monsterArr:Array;
		private var map:IMapView;
		public static var GAME_MODE:uint;
		
		public function GameWorld()
		{
			super();
			
			if(stage)
			{
				initialize();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			}
		}
		
		private function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.color = 0;
			
			Starling.current.showStats = true;
			var stats:DisplayObject = Starling.current.stage.getChildAt(stage.numChildren-1);
			stats.y = 50;

			Starling.current.antiAliasing = 0;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandle);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandle);
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			MgrObjects.display3DMgr.init( this );
			MgrObjects.layer3DMgr.init();
			
			//MainMgr.instance.loadUI();
			//stage.addEventListener(TouchEvent.TOUCH, onTouch);
			MapLoader.load( onMapJsonLoadCompleteHandler );
		}
		
		private function onMapJsonLoadCompleteHandler( str:Object ):void{
			
			//1 平面 ，2斜角，3TIle斜角
			GAME_MODE = 3;
			
			TextureMgr.instance.init();
			
			var strMapData:Object = str;
			if(GAME_MODE == 1){
				map = new MapView3D();
			} else if(GAME_MODE == 2){
				map = new TileMapView3D();
			} else if(GAME_MODE == 3){
				map = new Tile25MapView3D();
			}
			
			stage.addChild( map as BaseView3D);
			map.init( strMapData["mapdata"] );
			
			if(GAME_MODE == 1){
				p = new PeopleView3D();
			} else if(GAME_MODE == 2 || GAME_MODE == 3){
				p = new TilePeopleView3D();
			}
			p.init( [1,8,5,4] );
			p.draw();
			map.addPlayer( p );
			
			monsterArr = [];
			
			for(var i:uint=4;i<12;i++){
				for(var j:uint=4;j<12;j++){
					if(GAME_MODE == 1){
						monster = new MonsterView3D();
					} else if(GAME_MODE == 2 || GAME_MODE == 3){
						monster = new TileMonsterView3D();
					}
					monsterArr.push(monster);
					monster.init( [3,j,i] );
					monster.draw();
					map.addMonster( monster );
				}
			}
			
			stage.addEventListener(Event.ENTER_FRAME, onUpdateHandler);
			KeyBoardMgr.instance.init( MgrObjects.displayMgr.getStage );;
		}
		
		/**
		 * 八面
		 * 1下 2右下 3右 4右上 5上 6左上 7左 8左下
		 * @param e
		 */			
		private function onUpdateHandler(e:Event):void{
			
			if(p){
				p.onInputHandler( map );
			}
			for each(monster in monsterArr){
				if(monster){
					monster.onInputHandler( map );
				}
			}
		}
		private function onRemovedFromStage(event:Event):void
		{
			//stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		/**
		 * 
		 * @param event
		 */		
		private function onEnterFrame(event:EnterFrameEvent):void
		{
			
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				trace( "[RpgMain]" + touch.globalX, touch.globalY );
			}			
		}
		
		private function onMouseDown(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
		}
		
		
		private function onKeyUpEventHandle(e:KeyboardEvent):void
		{
			trace("onKeyUpEventHandle:", e.keyCode);
		}
		
		private function onKeyDownEventHandle(e:KeyboardEvent):void
		{
			trace("onKeyDownEventHandle:", e.keyCode);
		}
	}
}