package game.starling.view
{
	import game.core.managers.nostarling.DisplayMgr;
	import game.core.managers.starling.Display3DMgr;
	import common.utils.MgrObjects;
	
	import flash.events.Event;
	
	import org.rpg.controllers.tile.TileSkillBallController;
	import game.core.events.ModelEvent;
	import game.core.events.SkillEvent;
	import game.core.interfaces.IMapView;
	import org.rpg.managers.Depth3DMgr;
	import game.app.managers.DepthMgr;
	import org.rpg.models.MapModel;
	import org.rpg.models.ObjectModel;
	import game.core.models.TileSkillBallModel;

	public class TileSkillBallView3D extends SkillBallView3D
	{
		private var _model:TileSkillBallModel;
		private var _controller:TileSkillBallController;
		
		/**
		 * 
		 * @return 
		 */		
		public function get controller():TileSkillBallController {
			return _controller;;
		}
		/**
		 * 
		 * @return 
		 */		
		override public function get model():* {
			return this._model;
		}
		
		public function TileSkillBallView3D()
		{
			super();
		}
		
		/**
		 * 
		 * @param data
		 */		
		override public function init(data:Object=null):void {
			
			_model = new TileSkillBallModel();
			_model.addEventListener( SkillEvent.SKILL_REMOVE, onRemoveSkillHandler);
			_controller = new TileSkillBallController();
			_controller.init(_model);
			
			_model.modX = data[0];
			_model.modY = data[1];
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_model.speed = data[2];
			
			super.create( data );
			
			super.x = _model.posX;
			super.y = _model.posY;

			_model.getPos( 2 );
			
		}
		
		/**
		 * 
		 * @param event
		 */		
		override protected function onRemoveSkillHandler(event:Event):void
		{
			_model.removeEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_model.removeEventListener( SkillEvent.SKILL_REMOVE, onRemoveSkillHandler);
			MgrObjects.display3DMgr.removeForParent( mImage );
			hasRemoved = true;
		}
		/**
		 * 
		 */		
		override public function draw():void {
			var tempRate:uint = _model.dir / 8;
			var tempDir:uint;
			if(_model.dir % 8 != 1){
				tempDir = (_model.dir - 1 > 0)?(_model.dir - 1):8 * (tempRate + 1);
			} else {
				tempDir = 8 * (tempRate + 1);
			}
			if(this.parent){
				Depth3DMgr.swapDepth(this, model.posY);
			}
		}
		/**
		 * 
		 * @param e
		 */		
		override public function onInputHandler( map:IMapView ):void {
			
			if(currentMap != map){
				currentMap = map;
			}
			controller.onInputHandler( map );
		}
	}
}