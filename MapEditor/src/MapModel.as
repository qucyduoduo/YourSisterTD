package
{
	import data.MapData;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	public class MapModel extends Sprite
	{
		public function MapModel()
		{
		}
		
		public function update( mapData:MapData ):void
		{
			var iLen:int = mapData.dataList.length;
			for( var i:int = 0;i<iLen;i++)
			{
				makeBlock( mapData.dataList[i], i );
			}
		}
		
		private function makeBlock( data:int , i:int ):void
		{
			var WIDTH:Number = 32 * 0.6;
			var posX:Number = ( i % 30 ) * WIDTH;
			var posY:Number = ( (i - ( i % 30 )) / 30) * WIDTH;
			graphics.beginFill( data?0x999999:0x333333 );
			graphics.lineStyle( 1, 0x999999, 1 );
			graphics.drawRect( posX, posY, WIDTH, WIDTH );
			graphics.endFill();
		}
	}
}