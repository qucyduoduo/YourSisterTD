package  game.core.managers
{
	import common.base.interfaces.IMgr;
	import common.utils.Counter;
	
	import debug.Debugger;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	import game.untils.MgrObjects;
	
	/**
	 * 调试管理器
	 */    
	public class DebugMgr extends Debugger implements IMgr
	{
		public const INFO:int = 1;
		public const ERROR:int = 2;
		public const DEBUG:int = 3;
		public const PACKET_SEND:int = 11;
		public const PACKET_RECV:int = 12;
		public const PACKET_BUFF:int = 13;
		
		
		private var _isDisposed:Boolean;
		private var _debugInfo:TextField;
		private var _outputArea:Sprite;
		private var _showDebugInfo:Sprite;
		private var _debugInfoBg:Shape;
		private var _showDebugInfoLabel:TextField;
		private var _timeArea:TextField;
		
		private var _clearDebugInfo:Sprite;
		
		public function DebugMgr():void
		{
			_outputArea = new Sprite();
			
			_showDebugInfo = generateButton(81,24,"hide");
			_showDebugInfo.addEventListener(MouseEvent.CLICK, onDebugInfoVisibleHandle);
			_showDebugInfoLabel = _showDebugInfo.getChildAt(0) as TextField;
			
			_clearDebugInfo = generateButton(81,24,"clean");
			_clearDebugInfo.x = 87;
			_clearDebugInfo.addEventListener(MouseEvent.CLICK, onClearDebugInfo);
			
			_timeArea = new TextField();
			_timeArea.autoSize = TextFieldAutoSize.LEFT;
			_timeArea.textColor = 0x00cc66;
			_timeArea.y = 30;
			_timeArea.filters = [new DropShadowFilter(0,0,0,1,2,2,8)];
			
			
			_debugInfo = new TextField(); 
			_debugInfo.defaultTextFormat = new TextFormat("arial", 12, 0xffffff, null,null,null,null,null,TextFormatAlign.LEFT,0,0,0,6);
			_debugInfo.filters = [new DropShadowFilter(0,0,0,1,2,2,8)]
			_debugInfo.width = 450;
			_debugInfo.height = 576;
			_debugInfo.y = 35;
			_debugInfo.wordWrap = true;
			_debugInfo.multiline = true;
			
			_debugInfoBg = new Shape();
			_debugInfoBg.graphics.beginFill(0,.5);
			_debugInfoBg.graphics.drawRect(0,30,450,576);
			_debugInfoBg.graphics.endFill();
			
			_outputArea.addChild(_debugInfoBg);
			_outputArea.addChild(_clearDebugInfo);
			_outputArea.addChild(_showDebugInfo);
			_outputArea.addChild(_timeArea);
			_outputArea.addChild(_debugInfo);
			
			_outputArea.y = 0;
			
			_outputFunc = outputHtml;
			
			_timeArea.mouseEnabled = false;
//			_debugInfo.mouseEnabled = false;
		}
		
		protected function generateButton(width:int, height:int, label:String, btnColor:uint = 0xeeeeee, btnShadow:uint = 0x666666):Sprite
		{
			var generateBtn:Sprite = new Sprite();
			generateBtn.graphics.beginFill(btnShadow);
			generateBtn.graphics.drawRect(0,0,width,height);
			generateBtn.graphics.beginFill(btnColor);
			generateBtn.graphics.drawRect(2,2,width-5,height-5);
			generateBtn.graphics.endFill();
			var btnLabel:TextField = new TextField();
			btnLabel.defaultTextFormat = new TextFormat("arial", 12, 0, null,null,null,null,null,TextFormatAlign.CENTER);
			btnLabel.width = 80;
			btnLabel.height = 25;
			btnLabel.x = 2;
			btnLabel.y = 2;
			btnLabel.text = label;
			generateBtn.addChild(btnLabel);
			generateBtn.mouseChildren = false;
			generateBtn.useHandCursor = true;
			generateBtn.buttonMode = true;
			return generateBtn;
		}
		
		protected function onClearDebugInfo(e:MouseEvent):void
		{
			_debugInfo.htmlText = "";
		}
		
		protected function onDebugInfoVisibleHandle(e:MouseEvent):void
		{
			if(_debugInfo.parent)
			{
				_outputArea.removeChild(_debugInfoBg);
				_outputArea.removeChild(_debugInfo);
				_outputArea.removeChild(_timeArea);
				_showDebugInfoLabel.text = "show";
			}
			else
			{
				_outputArea.addChild(_debugInfoBg);
				_outputArea.addChild(_debugInfo);
				_outputArea.addChild(_timeArea);
				_showDebugInfoLabel.text = "hide";
			}
			
		}
		
		public function dispose():void
		{
			if(_isDisposed == false)
			{
				distruct();
				_isDisposed = true;
			}
		}
		
		protected function outputHtml(...params):void
		{
			var info:String = params[0];
			var color:String;
			var infoType:int = int(params[1]);
			switch(infoType)
			{
				case ERROR:
				{
					color = "#ff0000";
					break
				}
				case PACKET_SEND:
				{
					color = "#ffff00";
					break
				}
				case PACKET_RECV:
				{
					color = "#00ff00";
					break
				}
				case PACKET_BUFF:
				{
					color = "#80ffff";
					break
				}
					
				case DEBUG:
				case INFO:
				default:
				{
					break;
				}
			}
			if(color)
			{
				info = '<font color="'+color+'">'+info+'</font>';
			}
			
			var date:Date = new Date();
			date.time = getTimer();
			_debugInfo.htmlText += '['+date.hoursUTC+":"+date.minutesUTC+":"+date.secondsUTC+'] ' + info;
			_debugInfo.scrollV = _debugInfo.maxScrollV;
			
			trace(params[0]);
			
		}
		
		
		override public function log(...params):void
		{
			if( _outputArea.parent == null)
			{
				MgrObjects.displayMgr.getStage.addChild(_outputArea);
				_outputArea.x = MgrObjects.displayMgr.getStageRect().width >> 1;
			}
			var str:String = '';
			var len:int = params.length;
			for(var i:int = 0; i<len; i++)
			{
				str += params[i];
				if((i + 1)<len)
				{
					str += " ";
				}
			}
			_outputFunc.apply (null, [str]);
		}
		
		override public function serverLog(...params):void
		{
			_outputFunc.apply (null, params);
		}
		
		protected function distruct():void
		{
			
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
	}
}