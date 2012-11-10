package views
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * LoadingView 进度条视图类
	 * @author noah
	 * @version 0.0.1
	 * 
	 */	
	public class LoadingView extends EventDispatcher
	{
		private var loadingBg:Shape;
		private var loadingBar:Shape;
		private var loadingBarBg:Shape;
		private var loadingText:TextField;
		private var loadingTextFormat:TextFormat;
		
		private var container:DisplayObjectContainer;
		
		private var x:Number;
		private var y:Number;
		private var width:Number;
		private var height:Number;
		private var barHeight:Number;
		
		private var isDestoryed:Boolean;
		
		public function LoadingView()
		{
			//this.container = container;
			
			width = 400;
			height = 300;
			barHeight = 18;
			x = 0;
			y = 0;
			
			loadingBg = new Shape();
			loadingBg.x = x;
			loadingBg.y = y;
			loadingBg.graphics.beginFill(0x333333,1);
			loadingBg.graphics.drawRect(0,0,width,height);
			loadingBg.graphics.endFill();
			loadingBg.visible = false;

			loadingBarBg = new Shape();
			loadingBarBg.x = x;
			loadingBarBg.y = y + height - barHeight;
			loadingBarBg.graphics.beginFill(0x000000,1);
			loadingBarBg.graphics.drawRect(0,0,width, barHeight);
			loadingBarBg.graphics.endFill();
			
			loadingBar = new Shape();
			loadingBar.x = x;
			loadingBar.y = y + height - barHeight;
			
			loadingTextFormat = new TextFormat();
			loadingTextFormat.color = 0xffffff;
			loadingTextFormat.align = "center";
			
			loadingText = new TextField();
			loadingText.width = width;
			loadingText.height = 18;
			loadingText.x = x;
			loadingText.y = y + height - barHeight;
			loadingText.defaultTextFormat = loadingTextFormat;
			
			
		}

		public function init(data:Object=null):void
		{
			// TODO Auto-generated method stub
		}

		public function show():void
		{
			container.addChild(loadingBg);
			container.addChild(loadingBarBg);
			container.addChild(loadingBar);
			container.addChild(loadingText);
		}
		
		public function hide():void
		{
			container.removeChild(loadingBg);
			container.removeChild(loadingBarBg);
			container.removeChild(loadingBar);
			container.removeChild(loadingText);
		}
		
		/**
		 * 
		 * @param byteLoaded
		 * @param byteTotal
		 */		
		public function update(byteLoaded:Number, byteTotal:Number):void
		{
			//如果本实例已经被销毁，则不运行
			if(isDestoryed)
			{
				return;
			}
			loadingBar.graphics.clear();
			loadingBar.graphics.beginFill(0x666666,1);
			loadingBar.graphics.drawRect(0,0,byteLoaded/byteTotal * width, barHeight);
			loadingBar.graphics.endFill();
			
			loadingText.text = byteLoaded + "/" + byteTotal + "字节";
			
			//trace("[main.view.LoadingView] ========================================" + byteLoaded + "/" + byteTotal + "字节");
			
			if(byteLoaded >= byteTotal)
			{
				this.hide();
				return;
			}
		}

		/**
		 * 移除销毁所有视图
		 */		
		public function destroy():void
		{
			if(loadingBg)
			{
				container.removeChild(loadingBg);
				loadingBg = null;
			}
			if(loadingBarBg)
			{
				container.removeChild(loadingBarBg);
				loadingBarBg = null;
			}
			if(loadingBar)
			{
				container.removeChild(loadingBar);
				loadingBar = null;
			}
			if(loadingText)
			{
				container.removeChild(loadingText);
				loadingText = null;
			}
			isDestoryed = true;
		}
	}
}