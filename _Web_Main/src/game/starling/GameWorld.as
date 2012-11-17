package game.starling
{
	import common.base.views.starling.BaseView;
	
	import game.app.managers.KeyBoardMgr;
	import game.core.interfaces.IMapView;
	import game.core.map.Map;
	import game.core.map.Tile25Map;
	import game.core.map.TileMap;
	import game.core.unit.starling.Character3DUint;
	import game.core.unit.starling.Enemy3DUnit;
	import game.core.unit.starling.TileCharacter3DUnit;
	import game.core.unit.starling.TileEnemy3DUnit;
	import game.untils.MapLoader;
	import game.untils.MgrObjects;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameWorld extends Sprite
	{
		/**
		 * 
		 */		
		private var characterUnit:Character3DUint;
		/**
		 * 
		 */		
		private var enemyUnit:Enemy3DUnit;
		/**
		 * 
		 */		
		private var enemyUnitArr:Array;
		/**
		 *  
		 */		
		private var map:IMapView;
		/**
		 * 
		 */		
		public static var GAME_MODE:uint;
		
		public function GameWorld()
		{
			super();
			if(stage) initialize();
			else addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.color = 0;
			
			Starling.current.showStats = true;
//			var stats:DisplayObject = Starling.current.stage.getChildAt(stage.numChildren-1);
//			stats.y = 50;

			Starling.current.antiAliasing = 0;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandle);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandle);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
//			MgrObjects.uiMgr.init(();
			MapLoader.load( onMapJsonLoadCompleteHandler );
		}
		
		private function onMapJsonLoadCompleteHandler( str:Object ):void{
			
			//1 平面 ，2斜角，3TIle斜角
			GAME_MODE = 1;
			
			var strMapData:Object = str;
			if(GAME_MODE == 1)
			{
				map = new Map();
			}
			else if(GAME_MODE == 2)
			{
				map = new TileMap();
			} 
			else if(GAME_MODE == 3)
			{
				map = new Tile25Map();
			}
			
			stage.addChild( map as BaseView);
			map.init( strMapData["mapdata"] );
			
			if(GAME_MODE == 1)
			{
				characterUnit = new Character3DUint();
			}
			else if(GAME_MODE == 2 || GAME_MODE == 3)
			{
				characterUnit = new TileCharacter3DUnit();
			}
			characterUnit.init( [1,8,5,4] );
			characterUnit.draw();
			map.addPlayer( characterUnit );
			
			enemyUnitArr = [];
			
			for(var i:uint=4;i<8;i++)
			{
				for(var j:uint=4;j<8;j++)
				{
					if(GAME_MODE == 1)
					{
						enemyUnit = new Enemy3DUnit();
					}
					else if(GAME_MODE == 2 || GAME_MODE == 3)
					{
						enemyUnit = new TileEnemy3DUnit();
					}
					enemyUnitArr.push(enemyUnit);
					enemyUnit.init( [3,j,i] );
					enemyUnit.draw();
					map.addMonster( enemyUnit );
				}
			}
			
			KeyBoardMgr.instance.init( MgrObjects.displayMgr.getStage );;
		}
		
		/**
		 * 八面
		 * 1下 2右下 3右 4右上 5上 6左上 7左 8左下
		 * @param e
		 */			
		private function onEnterFrame(e:EnterFrameEvent):void{
			
			if( characterUnit )
			{
				characterUnit.onInputHandler( map );
			}
			for each(enemyUnit in enemyUnitArr)
			{
				if(enemyUnit)
				{
					enemyUnit.onInputHandler( map );
				}
			}
		}
		private function onRemovedFromStage(event:Event):void
		{
			//stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				trace( "[GameWorld] onTouch " + touch.globalX, touch.globalY );
			}			
		}
		
		private function onMouseDown(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
		}
		
		
		private function onKeyUpEventHandle(e:KeyboardEvent):void
		{
//			trace("onKeyUpEventHandle:", e.keyCode);
		}
		
		private function onKeyDownEventHandle(e:KeyboardEvent):void
		{
//			trace("onKeyDownEventHandle:", e.keyCode);
		}
	}
}