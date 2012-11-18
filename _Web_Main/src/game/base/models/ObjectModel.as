package game.base.models
{
	import common.base.models.BaseModel;
	
	import flash.geom.Rectangle;
	
	import game.core.events.ModelEvent;
	import game.core.interfaces.IObjectModel;
	import game.core.models.statics.MapModel;
	
	/**
	 * 物体模型
	 * @author noah
	 */	
	public class ObjectModel extends BaseModel implements IObjectModel
	{
		protected var _type:int;
		protected var _dir:int = 1;
		protected var _oldDir:int;
		protected var _x:Number;
		protected var _y:Number;
		protected var _hitRect:Rectangle;
		
		public function ObjectModel()
		{
			super();
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}

		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get dir():uint
		{
			return _dir;
		}
		
		public function set dir(value:uint):void
		{
			_dir = value;
			if(_dir != _oldDir)
			{
				_oldDir = _dir;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
	}
}