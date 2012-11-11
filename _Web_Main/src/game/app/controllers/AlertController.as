package game.app.controllers
{
	import common.base.controllers.BaseController;
	import common.base.interfaces.IModel;
	import common.base.interfaces.IView;
	import game.app.models.AlertModel;
	import game.app.factorys.ViewsFactory;
	import game.app.types.ViewType;
	
	import flash.events.Event;

	/**
	 * 弹出提示框控制器
	 * 
	 * @author noah
	 */	
	public class AlertController extends BaseController
	{
		/**
		 * 单例模式 
		 */		
		private static var _instance:AlertController;
		/**
		 * 单例访问器
		 * @return 
		 */		
		public static function get instance():AlertController 
		{
			if(_instance == null){
				_instance = new AlertController();
			}
			return _instance;
		}
		/**
		 * 
		 */		
		private var alertView:IView;
		/**
		 * 
		 */		
		private static var alertModelArr:Array;
		/**
		 * 构造函数
		 */		
		public function AlertController() 
		{
			if(_instance != null)
			{
				throw new Error("该类是单例模式");
			}
			_instance = this;
			
			alertModelArr = [];
		}
		/**
		 * 
		 */		
		private function show(str:String,applyFun:Function = null,cancelFun:Function = null):void
		{
			var alertModel:AlertModel = new AlertModel();
			alertModel.str = str;
			alertModel.applyFun = applyFun;
			alertModel.cancelFun = cancelFun;
			alertModelArr.push(alertModel);
			showNext();
		}
		/**
		 * 
		 */		
		private function showNext():void{
			
			if(alertModelArr.length == 0)
			{
				return ;
			}
			if(alertView == null)
			{
				var alertModel:IModel = alertModelArr.shift();
				alertView = ViewsFactory.newView( ViewType.ALERT, alertModel );
				alertView.show();
			}
			
		}
		/**
		 * 
		 * @param e
		 */		
		private function onCloseHandler(e:Event):void
		{
			
		}
		/**
		 * 
		 */		
		public function hide():void
		{
			/*alertModel = null;
			alertView.hide();*/
		}
		/**
		 * 
		 */		
		public static function show(str:String,applyFun:Function = null,cancelFun:Function = null):void
		{
			AlertController.instance.show( str, applyFun, cancelFun );
		
		}
	}
}