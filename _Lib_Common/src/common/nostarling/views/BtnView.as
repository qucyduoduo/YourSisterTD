package common.nostarling.views
{
	import common.base.interfaces.IModel;
	import common.base.views.BaseView;
	import common.events.BtnEvent;
	import common.models.BtnModel;
	import common.utils.MgrObjects;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class BtnView extends BaseView
	{
		private var btnBg:Shape;
		private var btnText:TextField;
		private var btnTextFormat:TextFormat;
		private var container:DisplayObjectContainer;
		
		private var pos:Point;
		private var _width:Number=0;
		private var _height:Number=0;
		private var btnModel:BtnModel;
		
		public function BtnView( btnModel:IModel ){
			
			this.btnModel = btnModel as BtnModel;
		}
		
		override public function show( ):void{
			
			this.container = btnModel.parent;
			this.pos = btnModel.pos;
			
			var rect:Rectangle = MgrObjects.displayMgr.getStageRect();
			_width = 80;
			_height = 30;
			if(pos){
				x = pos.x;
				y = pos.y;
			}else{
				x =( rect.width - _width) / 2;
				y =( rect.height - _height) / 2 + 50;
			}
			
			btnBg = new Shape();
			btnBg.graphics.beginFill(0x000000,1);
			btnBg.graphics.drawRect(0,0,_width,_height);
			btnBg.graphics.endFill();
			
			btnTextFormat = new TextFormat();
			btnTextFormat.color = 0xffffff;
			btnTextFormat.align = "center";
			
			btnText = new TextField();
			btnText.width = _width;
			btnText.height = _height - 5;
			btnText.y = 5;
			btnText.defaultTextFormat = btnTextFormat;
			btnText.text = btnModel.str;
			btnText.mouseEnabled = false;
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, onOutHandler);
			this.addChild( btnBg );
			this.addChild( btnText );
			container.addChild(this);
		}
		/**
		 * 
		 * @param e
		 */		
		override protected function onClickHandler(e:MouseEvent):void{
			super.onClickHandler( e );
			this.dispatchEvent(new BtnEvent(BtnEvent.BTN_CLICK_EVENT));
		}
		private function onOverHandler(e:MouseEvent):void{
			btnBg.graphics.beginFill(0x333333,1);
			btnBg.graphics.drawRect(0,0,width,height);
			btnBg.graphics.endFill();
		}
		private function onOutHandler(e:MouseEvent):void{
			btnBg.graphics.beginFill(0x000000,1);
			btnBg.graphics.drawRect(0,0,width,height);
			btnBg.graphics.endFill();
		}
		
		override public function destroy():void{
			if(btnBg){
				MgrObjects.displayMgr.removeForParent(btnBg);
				btnBg = null;
			}
			if(btnText)	{
				MgrObjects.displayMgr.removeForParent(btnText);
				btnText = null;
			}
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
			this.removeEventListener(MouseEvent.ROLL_OVER, onOverHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOutHandler);
		}
	}
}