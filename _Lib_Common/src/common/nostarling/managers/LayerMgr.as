package common.nostarling.managers
{
	import common.base.interfaces.IMgr;
	import common.managers.MainMgr;
	import common.managers.MgrType;
	import common.nostarling.layers.Layer;
	import common.nostarling.layers.LayerAvg;
	import common.nostarling.layers.LayerRpg;
	
	import flash.display.Sprite;

	/**
	 * 层管理器 
	 * @author noah
	 */	
	public class LayerMgr implements IMgr
	{
		/**
		 * 通用层
		 */		
		public var layer:Layer;
		/**
		 * 游戏AVG层
		 */		
		public var layerAvg:LayerAvg;		
		/**
		 * 游戏RPG层
		 */		
		public var layerRpg:LayerRpg;		
		private var _isDisposed:Boolean;
		/**
		 * 构造函数
		 */		
		public function LayerMgr() 
		{
		
		}
		/**
		 * 初始化层管理器
		 */		
		public function init():void
		{
			layer = new Layer();
			layerAvg = new LayerAvg();
			layerRpg = new LayerRpg();
			
			createLayers();
			createGameAvgLayers();
			createGameRPGLayers();
		}
		/**
		 * 创建基本层
		 */		
		private function createLayers():void 
		{
			for(var layerID:uint = 0 ;layerID<5;layerID++){
				var sp:Sprite = new Sprite();
				
				if(	layerID != Layer.GAME_RPG &&
				   	layerID != Layer.GAME_AVG && 
				   	layerID != Layer.UI ) {
					//对游戏层和界面层启用鼠标事件
					sp.mouseChildren = false;
					sp.mouseEnabled = false;
				}
				if(layerID == Layer.BACK){
					//对后层启用位图缓存
					sp.cacheAsBitmap = true;
				}
				layer.push(sp);
				(MainMgr.instance.getMgr( MgrType.DISPLAY_MGR ) as DisplayMgr).getStage.addChild(sp);
				//MainMgr.debugTrace( "[LayerMgr] 创建基本层: " + layerID);
			}
			sp = null;
		}
		/**
		 * 创建游戏层 
		 */		
		private function createGameAvgLayers():void
		{
			var gameLayer:Sprite = layer.gameAvgLevel;
			for(var layerID:uint = 0 ;layerID<7;layerID++){
				var sp:Sprite = new Sprite();
			
				if( layerID != LayerAvg.EVENT &&
					layerID != LayerAvg.UI){
					//仅仅对游戏事件层和游戏界面层启用鼠标事件
					sp.mouseChildren = false;
					sp.mouseEnabled = false;
				}
				if(layerID == LayerAvg.BACK_IMG){
					//对后层启用位图缓存
					sp.cacheAsBitmap = true;
				}
				layerAvg.push(sp);
				gameLayer.addChild(sp);
				//MainMgr.debugTrace( "[LayerMgr] 创建游戏层: " + layerID);
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

				if( layerID != LayerRpg.MAP_PEOPLE && 	layerID != LayerRpg.MAP_EVENT)
				{
					//仅仅对游戏地图人物层和游戏地图事件层启用鼠标事件
					sp.mouseChildren = false;
					sp.mouseEnabled = false;
				}
				layerRpg.push(sp);
				gameLayer.addChild(sp);
				//MainMgr.debugTrace( "[LayerMgr] 创建游戏层: " + layerID);
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