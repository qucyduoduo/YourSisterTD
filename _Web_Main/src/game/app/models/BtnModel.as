package game.app.models
{
	import common.base.models.BaseModel;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	/**
	 * 
	 * @author noah
	 */	
	public class BtnModel extends BaseModel{
		/**
		 * 
		 */		
		public var str:String = "";					//显示内容文本
		public var pos:Point;
		public var parent:DisplayObjectContainer;	//
		/**
		 * 
		 */		
		public function BtnModel(){
			super();
		}
	}
}