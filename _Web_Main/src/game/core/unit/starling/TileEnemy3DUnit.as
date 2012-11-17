package game.core.unit.starling
{
	import game.app.managers.DepthMgr;
	import game.core.controllers.dynamics.TileMonsterController;
	import game.core.events.ActionEvent;
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapView;
	import game.core.models.dynamics.TileMonsterModel;
	import game.core.models.statics.MapModel;
	
	public class TileEnemy3DUnit extends Enemy3DUnit
	{
		private var _model:TileMonsterModel;
		private var _controller:TileMonsterController;
		
		private function get controller():TileMonsterController
		{
			return _controller;
		}
		override public function get model():*{
			return this._model;
		}
		public function TileEnemy3DUnit()
		{
			super();
		}
		
		override public function init( data:Object = null):void{
			_model = new TileMonsterModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new TileMonsterController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_model.speed = 1;
			
			super.create( data[0] );
			
			super.x = _model.posX - (MapModel.TILE_BLOCK_WIDTH);
			super.y = _model.posY;
			
			_model.getPos( 2 );
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
		
		override public function draw():void{
			//这里需要面朝向转换，因为地图被倾斜了。
			var tempRate:uint = _model.dir / 8;
			var tempDir:uint;
			if(_model.dir % 8 != 1){
				tempDir = (_model.dir - 1 > 0)?(_model.dir - 1):8 * (tempRate + 1);
			} else {
				tempDir = 8 * (tempRate + 1);
			}
			if(_model.currentDir != tempDir){
				trace("[TilePeopleView]" + _model.currentDir, tempDir);
				_model.currentDir = tempDir;
			}
			if(this.parent){
				DepthMgr.swapDepth(this, model.posY);
			}
		}
	}
}