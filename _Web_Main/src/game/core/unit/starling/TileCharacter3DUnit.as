package  game.core.unit.starling
{
	import game.app.managers.Depth3DMgr;
	import game.app.managers.TextureMgr;
	import game.core.controllers.dynamics.TilePeopleController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IPeopleView;
	import game.core.models.dynamics.TilePeopleModel;
	import game.core.models.statics.MapModel;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class TileCharacter3DUnit extends Character3DUint implements IPeopleView
	{
		private var _model:TilePeopleModel;
		private var _controller:TilePeopleController;
		/**
		 * 
		 * @return 
		 */		
		public function get controller():TilePeopleController {
			return _controller;;
		}
		/**
		 * 
		 * @return 
		 */		
		override public function get model():* 
		{
			return this._model;
		}
		
		public function TileCharacter3DUnit() {
			
		}
		/**
		 * 
		 * @param data
		 */		
		override public function init(data:Object=null):void {
			
			_model = new TilePeopleModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new TilePeopleController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_model.speed = data[3];
			
			super.create( data[0] );
			
			super.x = _model.posX - (MapModel.TILE_BLOCK_WIDTH);
			super.y = _model.posY;
			
			_model.getPos( 2 );
			
		}
		/**
		 * 
		 */		
		override public function draw():void {
			
			if(_model.isGCD){
				if( isAniPlaying ){
					return;
				}
				isAniPlaying = true;
			} else {
				isAniPlaying = false;
			}
			//这里需要面朝向转换，因为地图被倾斜了。
			var tempRate:uint = _model.dir / 8;
			var tempDir:uint;
			if(_model.dir % 8 != 1){
				tempDir = (_model.dir - 1 > 0)?(_model.dir - 1):8 * (tempRate + 1);
			} else {
				tempDir = 8 * (tempRate + 1);
			}
			if(_model.currentDir != tempDir){
				trace("[TilePeopleView3D]" + _model.currentDir, tempDir);
				_model.currentDir = tempDir;
				removeChild(m);
				Starling.juggler.remove(m);
				if(tempDir < 10){
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m0" + tempDir), frameRate);
				} else {
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m" + tempDir), frameRate);
				}
				m.x = -20;
				m.y = -80;
				trace( "[TilePeopleView3D] 当前 tempDir: " + tempDir );
				addChild(m);
				Starling.juggler.add(m);
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