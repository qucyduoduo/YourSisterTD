package  common.core.display.starling
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class FrameImage extends Image
	{
		/**
		 * 顺序 
		 */		
		public var index:int;
		/**
		 * 分类顺序 
		 */		
		public var sortIndex:int;
		
		public function FrameImage(texture:Texture)
		{
			super(texture);
		}
	}
}