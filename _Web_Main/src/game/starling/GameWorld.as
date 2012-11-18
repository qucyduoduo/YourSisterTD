package game.starling
{
	import common.base.views.starling.BaseView;
	
	import game.core.interfaces.view.IMapView;
	import game.core.map.MapView;
	import game.core.unit.CharacterUint;
	import game.core.unit.EnemyUnit;
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
		private var _characterUnit:CharacterUint;
		/**
		 * 
		 */		
		private var _enemyUnit:EnemyUnit;
		/**
		 * 
		 */		
		private var _enemyUnitArr:Array;
		/**
		 *  
		 */		
		private var _map:IMapView;
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
			MgrObjects.mapMgr.loadMap( onMapJsonLoadCompleteHandler );
		}
		
		private function onMapJsonLoadCompleteHandler( str:Object ):void{
			
			//1 平面 ，2斜角
			GAME_MODE = 1;
			
			var strMapData:Object = str;
			if(GAME_MODE == 1)
			{
				_map = new MapView( strMapData["mapdata"] );
				_map.init();
			}
			else if(GAME_MODE == 2)
			{
//				map = new TileMap();
				return;
			} 
			
			stage.addChild( _map as BaseView );
			
			if(GAME_MODE == 1)
			{
//				_characterUnit = new CharacterUint();
			}
			else if(GAME_MODE == 2 || GAME_MODE == 3)
			{
//				characterUnit = new TileCharacterUnit();
			}
//			_characterUnit.init( [1,8,5,4] );
//			_map.addPlayer( _characterUnit );
			
//			_enemyUnitArr = [];
			
//			for(var i:uint=4;i<8;i++)
//			{
//				for(var j:uint=4;j<8;j++)
//				{
//					if(GAME_MODE == 1)
//					{
//						enemyUnit = new EnemyUnit();
//					}
//					else if(GAME_MODE == 2 || GAME_MODE == 3)
//					{
//						enemyUnit = new TileEnemyUnit();
//					}
//					enemyUnitArr.push(enemyUnit);
//					enemyUnit.init( [3,j,i] );
//					enemyUnit.draw();
//					map.addMonster( enemyUnit );
//				}
//			}
			
//			KeyBoardMgr.instance.init( MgrObjects.displayMgr.getStage );;
		}
		
		/**
		 * 八面
		 * 1下 2右下 3右 4右上 5上 6左上 7左 8左下
		 * @param e
		 */			
		private function onEnterFrame(e:EnterFrameEvent):void
		{
//			if(_map)
//			{
//				(_map as BaseView).sortChildren( sortFunction );
//			}
//			if( characterUnit )
//			{
//				characterUnit.onInputHandler( map );
//			}
//			for each(enemyUnit in enemyUnitArr)
//			{
//				if(enemyUnit)
//				{
//					enemyUnit.onInputHandler( map );
//				}
//			}
		}
		
//		private function sortFunction( objA:DisplayObject, objB:DisplayObject ):Number
//		{
//			return (objA.y*2560+objA.x)-(objB.y*2560+objB.x);
//		}
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