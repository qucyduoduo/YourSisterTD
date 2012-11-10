package  game.models.statics
{
	import game.interfaces.IMapModel;

	/**
	 * 2D地图模型
	 * @author noah
	 */	
	public class MapModel extends StaticObjectModel implements IMapModel
	{
		public static const TILE_BLOCK_WIDTH:uint = 32;
		public static const BLOCK_WIDTH:uint = 32;
		public static const STAGE_WIDTH:uint = 800;
		public static const STAGE_HEIDHT:uint = 600;
		
		private var _dataArr:Array;
		public function get dataArr():Array{
			return this._dataArr;
		}
		public function set dataArr(value:Array):void{
			this._dataArr = value;
		}
		/**
		 * 构造函数
		 * 导入地图数据
		 * @param data
		 */		
		public function MapModel( data:Object )
		{
			super();
			
			if(data){
				var dataObj:Object =  data;
				dataArr = dataObj as Array;
			}
		}
		
		public function onHitTestGrid(model:*):Boolean
		{
			if( dataArr[model.gridY][model.gridX] > 0){
				return true;
			} else {
				var gridXs:Array = model.gridXs;
				var gridYs:Array = model.gridYs;
				//trace("[MapModel]" + gridXs[0],gridXs[1]);
				if(dataArr[model.gridY][gridXs[0]] > 0 || dataArr[model.gridY][gridXs[1]] > 0){
					return true;
				}
				if(dataArr[gridYs[0]][model.gridX] > 0 || dataArr[gridYs[1]][model.gridX] > 0){
					return true;
				}
				return false;
			}
		}
	}
}