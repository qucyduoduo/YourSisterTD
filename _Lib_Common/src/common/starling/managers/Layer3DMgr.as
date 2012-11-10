package common.starling.managers
{
	import common.base.interfaces.IMgr;
	import common.starling.layers.Layer3D;
	import common.starling.layers.LayerAvg3D;
	import common.starling.layers.LayerRpg3D;
	import common.utils.MgrObjects;
	
	import starling.display.Sprite;

	/**
	 * 层管理器 
	 * @author noah
	 */	
	public class Layer3DMgr implements IMgr
	{
		/**
		 * 通用层
		 */		
		public var layer:Layer3D;
		/**
		 * 游戏AVG层
		 */		
		public var layerAvg:LayerAvg3D;		
		/**
		 * 游戏RPG层
		 */		
		public var layerRpg:LayerRpg3D;		
		private var _isDisposed:Boolean;
		/**
		 * 构造函数
		 */		
		public function Layer3DMgr() 
		{
			
		}
		/**
		 * 初始化层管理器
		 */		
		public function init():void
		{
			layer = new Layer3D();
			layerAvg = new LayerAvg3D();
			layerRpg = new LayerRpg3D();
			
			createLayers();
			createGameAvgLayers();
			createGameRPGLayers();
		}
		/**
		 * 创建基本层
		 */		
		private function createLayers():void {

			for(var layerID:uint = 0 ;layerID<5;layerID++){
				var sp:Sprite = new Sprite();
				
				if(	layerID != Layer3D.GAME_RPG &&
				   	layerID != Layer3D.GAME_AVG && 
				   	layerID != Layer3D.UI ) {
					//对游戏层和界面层启用鼠标事件
					/*sp.mouseChildren = false;
					sp.mouseEnabled = false;*/
				}
				if(layerID == Layer3D.BACK){
					//对后层启用位图缓存
					/*sp.cacheAsBitmap = true;*/
				}
				layer.push(sp);
				MgrObjects.display3DMgr.getStage.addChild(sp);
				//MainMgr.debugTrace( "[Layer3DMgr] 创建基本层: " + layerID);
			}
			sp = null;
		}
		/**
		 * 创建游戏层 
		 */		
		private function createGameAvgLayers():void{
			
			var gameLayer:Sprite = layer.gameAvgLevel;
			for(var layerID:uint = 0 ;layerID<7;layerID++){
				var sp:Sprite = new Sprite();
			
				if( layerID != LayerAvg3D.EVENT &&
					layerID != LayerAvg3D.UI){
					//仅仅对游戏事件层和游戏界面层启用鼠标事件
					/*sp.mouseChildren = false;
					sp.mouseEnabled = false;*/
				}
				if(layerID == LayerAvg3D.BACK_IMG){
					//对后层启用位图缓存
					/*sp.cacheAsBitmap = true;*/
				}
				layerAvg.push(sp);
				gameLayer.addChild(sp);
				//MainMgr.debugTrace( "[Layer3DMgr] 创建游戏层: " + layerID);
			}
			sp = null;
		}
		/**
		 * 创建游戏RPG层 
		 */		
		private function createGameRPGLayers():void
		{
			var gameLayer:Sprite = layer.gameRpgLevel;
			for(var layerID:uint = 0 ;layerID<6;layerID++){
				var sp:Sprite = new Sprite();

				if( layerID != LayerRpg3D.MAP_PEOPLE &&
					layerID != LayerRpg3D.MAP_EVENT){
					//仅仅对游戏地图人物层和游戏地图事件层启用鼠标事件
					/*sp.mouseChildren = false;
					sp.mouseEnabled = false;*/
				}
				layerRpg.push(sp);
				gameLayer.addChild(sp);
				//MainMgr.debugTrace( "[Layer3DMgr] 创建游戏层: " + layerID);
			}
			sp = null;
		}
		
		public function dispose():void
		{
			if(_isDisposed == false)
			{
				distruct();
				_isDisposed = true;
			}
		}
		
		protected function distruct():void
		{
			//TODO dispose resource table.
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}