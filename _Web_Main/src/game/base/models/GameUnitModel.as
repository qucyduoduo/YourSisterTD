package game.base.models
{
	import common.base.models.BaseModel;
	
	import flash.geom.Rectangle;
	
	import game.base.interfaces.IGameUnitModel;
	import game.core.events.ModelEvent;
	
	/**
	 * 物体模型
	 * @author noah
	 */	
	public class GameUnitModel extends BaseModel implements IGameUnitModel
	{
		/**
		 * 碰撞类型: 0 无碰撞 1 碰撞 
		 */		
		protected var _type:int;
		/**
		 * 原始碰撞类型 
		 */		
		protected var _oldType:int;
		/**
		 * 方向:  
		 */		
		protected var _dir:int = 1;
		/**
		 * 原始方向:  
		 */		
		protected var _oldDir:int;
		/**
		 * 原始坐标 
		 */		
		protected var _oldX:Number;
		protected var _oldY:Number;
		/**
		 * 碰撞区域: 矩形 
		 */		
		protected var _hitRect:Rectangle;
		
		public function GameUnitModel()
		{
			super();
		}
		
		/**
		 *  碰撞类型
		 * @return 
		 */		
		public function get type():int
		{
			return _type;
		}
		public function set type(value:int):void
		{
			if( value != _type)
			{
				_oldType = _type = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE_TYPE));
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}

		
		override public function get x():Number
		{
			return _x;
		}
		override public function set x(value:Number):void
		{
			if( value != _x)
			{
				_oldX = _x = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE_X));
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		
		override public function get y():Number
		{
			return _y;
		}
		override public function set y(value:Number):void
		{
			if( value != _y)
			{
				_oldY = _y = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE_Y));
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		
		public function get dir():uint
		{
			return _dir;
		}
		public function set dir(value:uint):void
		{
			if( value != _oldDir)
			{
				_oldDir =_dir = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE_DIR));
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
	}
}