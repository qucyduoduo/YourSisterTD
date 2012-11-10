package common.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	import flash.filters.ShaderFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 便捷文本工具类 
	 * @author noah
	 * 
	 */	
	public class TextTool
	{
		private var textArr:Array;
		
		public function TextTool()
		{
			textArr = [];
		}
		
		private static var _instance:TextTool;
		
		public static function get instance():TextTool
		{
			if(!_instance)
			{
				_instance = new TextTool();
			}
			return _instance;
		}
		/**
		 * 在容器中添加TextField 
		 * @param parent	父容器
		 * @param str		文本内容
		 * @param format	字体
		 * @param posx		在容器中x坐标
		 * @param posy		在容器中y坐标
		 * @param width		文本框宽度
		 * @param height	文本框高度
		 * 
		 */		
		public static function addTextField( parent:DisplayObjectContainer, 
											 str:String, 
											 format:TextFormat = null, 
											 filterObj:BitmapFilter = null,
											 posx:int = 0, 
											 posy:int = 0, 
											 width:int = 0, 
											 height:int = 0):void{
			
			instance;
			//parent.addEventListener(Event.REMOVED_FROM_STAGE, TextTool.instance.onRemoveTextField);
			var textField:TextField = new TextField();
			textField.defaultTextFormat = format;
			textField.text = str;
			if(filterObj){
				textField.filters = [filterObj];
			}
			textField.x = posx;
			textField.y = posy;
			if(width){
				textField.width = width;
			}
			if(height){
				textField.height = height;
			}
			_instance.textArr.push(textField);
			textField.mouseEnabled = false;
			parent.addChild(textField);
		}
		
		public static function setText(index:uint, str:String):void{
			
			var textField:TextField = _instance.textArr[index];
			textField.text = str;
			
		}
		
		/**
		 * 从显示列表移除TextField 
		 * @param e
		 * 
		 */		
		/*private function onRemoveTextField(e:Event):void{
			
			var parent:DisplayObjectContainer = e.currentTarget as DisplayObjectContainer;
			if(parent){
				parent.removeEventListener(Event.REMOVED_FROM_STAGE, TextTool.instance.onRemoveTextField);
				DisplayUtil.removeAllChild(parent);
			} else {
				
			}
		}*/
	}
}