package game.app.models
{
	import common.base.models.BaseModel;

	/**
	 * 
	 * 
	 * @author noah
	 */	
	public class AlertModel extends BaseModel{
		
		public var title:String = ""			//标题文本
		public var str:String = "";				//显示内容文本
		public var applyFun:Function = null;	//确定方法回调
		public var cancelFun:Function = null;	//取消方法回调
		/**
		 * 
		 */		
		public function AlertModel(){
			super();
		}
		/**
		 * 
		 */		
		override public function update():void{
			
		}
	}
}