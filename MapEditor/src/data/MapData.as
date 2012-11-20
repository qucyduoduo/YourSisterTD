package data
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;

	public class MapData
	{
		public static const MAP_FILE_HEAD:String = "MAP";
		private var _dataList:Vector.<int>;
		public function get dataList():Vector.<int>
		{
			return _dataList;
		}
		
		public function MapData()
		{
			//create 30 * 20 fields
			_dataList = new Vector.<int>( 30 * 20 );
		}
		
		public function fromByteArray( bytes:ByteArray ):void
		{
			bytes.position = 0;
			var head:String = bytes.readUTF();
			
			var compressData:ByteArray = new ByteArray();
			bytes.readBytes( compressData );
			compressData.uncompress( CompressionAlgorithm.DEFLATE );
			var iLen:int = compressData.readUnsignedInt();
			for (var i:int = 0;i<iLen;i++)
			{
				_dataList[i] = compressData.readUnsignedInt();
			}
			trace( "len: " + iLen + " HEAD: " + head );
		}
		
		public function toByteArray():ByteArray
		{
			var compressData:ByteArray = new ByteArray();
			var iLen:int = _dataList.length;
			compressData.writeUnsignedInt( iLen );
			for(var i:int = 0;i<iLen;i++)
			{
				compressData.writeUnsignedInt( _dataList[i] );
			}
			compressData.deflate();
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTF( MAP_FILE_HEAD );
			bytes.writeBytes( compressData );
			return bytes;
		}
	}
}