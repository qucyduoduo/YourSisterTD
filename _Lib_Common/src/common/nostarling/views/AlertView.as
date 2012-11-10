package common.nostarling.views
{
	import common.base.interfaces.IModel;
	import common.base.views.BaseView;
	import common.events.AlertEvent;
	import common.events.BtnEvent;
	import common.models.AlertModel;
	import common.models.BtnModel;
	import common.utils.MgrObjects;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 弹出框视图
	 * 
	 * @author noah
	 */	
	public class AlertView extends BaseView {
		
		private var alertModel:AlertModel;
		
		private var alertBg:Shape;
		private var alertText:TextField;
		private var alertTextFormat:TextFormat;
		
		private var okBtn:BtnView;
		private var cancleBtn:BtnView;
		
		private var pos:Point;
		private var _width:Number=0;
		private var _height:Number=0;
		
		/**
		 * 构造函数
		 */		
		public function AlertView( alertModel:IModel ) {
			
			this.alertModel = alertModel as AlertModel;
		}
		/**
		 * 
		 */		
		override public function show():void {
			
			var rect:Rectangle = MgrObjects.displayMgr.getStageRect();
			_width = 300;
			_height = 200;
			if(pos) {
				x = pos.x;
				y = pos.y;
			} else {
				x =(rect.width - _width) / 2 > 0?(rect.width - _width) / 2:0;
				y =(rect.height - _height) / 2 - 50 > 0?(rect.height - _height) / 2:0;
			}
			
			alertBg = new Shape();
			alertBg.x = x;
			alertBg.y = y;
			alertBg.graphics.beginFill(0x333333,0.5);
			alertBg.graphics.drawRect(0,0,_width,_height);
			alertBg.graphics.endFill();
			
			alertTextFormat = new TextFormat();
			alertTextFormat.color = 0xffffff;
			
			alertText = new TextField();
			alertText.multiline = true;
			alertText.wordWrap = true;
			alertText.width = _width * 0.6;
			alertText.height = _height * 0.6;
			alertText.x = x + 50;
			alertText.y = y + 50;
			alertText.defaultTextFormat = alertTextFormat;
			alertText.text = this.alertModel.str;
			alertText.mouseEnabled = false;
			
			var btnModel:BtnModel = new BtnModel();
			btnModel.str = "确定";
			btnModel.parent = this;
			btnModel.pos = new Point(x + 50, y + 100);
			okBtn = new BtnView( btnModel );
		
			btnModel = new BtnModel();
			btnModel.str = "取消";
			btnModel.parent = this;
			btnModel.pos = new Point(x + 150, y + 100);
			cancleBtn = new BtnView( btnModel );
			
			this.addChild( alertBg );
			this.addChild( alertText );
			MgrObjects.layerMgr.layer.uiLevel.addChild( this );
			okBtn.show();
			okBtn.addEventListener(BtnEvent.BTN_CLICK_EVENT, onOkBtnClickHandler);
			cancleBtn.show();
			cancleBtn.addEventListener(BtnEvent.BTN_CLICK_EVENT, onCancelBtnClickHandler);
		}
		/**
		 * 
		 * @param e
		 */		
		private function onOkBtnClickHandler(e:Event):void {
			
			if(alertModel.applyFun != null){
				alertModel.applyFun();
			}
			this.destroy();
		}
		/**
		 * 
		 * @param e
		 */		
		private function onCancelBtnClickHandler(e:Event):void {
			
			if(alertModel.cancelFun != null){
				alertModel.cancelFun();
			}
			this.destroy();
		}
		/**
		 * 隐藏
		 */		
		override public function hide():void{
			
			super.hide();
			
		}
		/**
		 * 销毁
		 */		
		override public function destroy():void	{
			
			super.destroy();
			if(alertBg) {
				MgrObjects.displayMgr.removeForParent(alertBg);
				alertBg = null;
			}
			if(alertText) {
				MgrObjects.displayMgr.removeForParent(alertText);
				alertText = null;
			}
			if(okBtn) {
				okBtn.destroy();
				okBtn = null;
			}
			if(cancleBtn) {
				cancleBtn.destroy();
				cancleBtn = null;
			}
			this.dispatchEvent(new AlertEvent(AlertEvent.ALERT_CLOSE_EVENT));
		}
	}
}