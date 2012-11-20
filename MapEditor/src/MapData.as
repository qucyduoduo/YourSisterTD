package
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;

	public class MapData
	{
		public static const MAP_FILE_HEAD:String = "MAP";
		
		public function MapData()
		{
			
		}
		
		public function fromByteArray( bytes:ByteArray ):void
		{
			bytes.position = 0;
			var head:String = bytes.readUTF();
			
			var compressData:ByteArray = new ByteArray();
			bytes.readBytes( compressData );
			compressData.uncompress( CompressionAlgorithm.DEFLATE );
			var len:uint = compressData.readUnsignedInt();
			trace( "len: " + len + " HEAD: " + head );
		}
		
		public function toByteArray():ByteArray
		{
			var compressData:ByteArray = new ByteArray();
			compressData.writeUnsignedInt( 0 );
			compressData.deflate();
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTF( MAP_FILE_HEAD );
			bytes.writeBytes( compressData );
			return bytes;
		}
	}
}