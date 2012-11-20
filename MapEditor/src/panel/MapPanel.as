package panel
{
	import com.bit101.components.Panel;
	
	import data.MapData;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class MapPanel extends Panel
	{
		private var _addType:int;
		private var _mapData:MapData;
		private var _mapModel:MapModel;
		
		public function set addType( value:int ):void
		{
			_addType = value;	
		}
		
		public function MapPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			_mapModel = new MapModel();
			addChild( _mapModel );
			_mapModel.addEventListener(MouseEvent.CLICK, onMapModelClickHandler);
		}
		
		protected function onMapModelClickHandler(e:MouseEvent):void
		{
			var WIDTH:Number = 32 * 0.6;
			var blockX:int = mouseX / WIDTH;
			var blockY:int = mouseY / WIDTH;
//			trace( "BlockXY: " + blockX + "," + blockY );
			_mapData.dataList[ blockX + blockY * 30 ] = _addType;
			_mapModel.update( _mapData );
		}
		
		public function setData( mapData:MapData ):void
		{
			_mapData = mapData;
			_mapModel.update( _mapData );
		}
	}
}