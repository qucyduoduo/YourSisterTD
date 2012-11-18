package  game.core.models.statics
{
	import game.core.interfaces.model.IMapModel;
	import game.base.models.StaticUnitModel;

	/**
	 * 2D地图模型
	 * @author noah
	 */	
	public class MapModel extends StaticUnitModel implements IMapModel
	{
		public static const MAP_WIDTH:int = 30;
		public static const MAP_HEIGHT:int = 20;
		
		public static const TILE_BLOCK_WIDTH:uint = 32;
		public static const BLOCK_WIDTH:uint = 32;
		
		private var _dataList:Vector.<int>;
		
		public function get dataList():Vector.<int>
		{
			return this._dataList;
		}
		/**
		 * 构造函数
		 * 导入地图数据
		 * @param data
		 */		
		public function MapModel( data:Object )
		{
			super();
			
			if(data)
			{
				var dataObj:Object =  data;
				var dataArr:Array = dataObj as Array;
				_dataList = new Vector.<int>();
				var iLen:int = dataArr.length;
				for(var i:int; i<iLen; i++)
				{
					_dataList.push( dataArr[i] );
				}
			}
		}
	}
}