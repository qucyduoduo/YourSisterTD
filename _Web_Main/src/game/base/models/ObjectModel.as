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
		public var num:uint;
		protected var _oldDir:uint;
		protected var _dir:uint = 1;
		protected var _modX:Number;
		protected var _modY:Number;
		protected var _hitRect:Rectangle;
		
		public function ObjectModel()
		{
			super();
		}
		
		public function get hitRect():Rectangle{
			return this._hitRect;
		}
		public function set hitRect(value:Rectangle):void{
			this._hitRect = value;
		}
		public function get posX():Number{
			return this._modX;
		}
		public function get posY():Number{
			return this._modY;
		}
		public function get modX():Number{
			return this._modX;
		}
		public function set modX(value:Number):void{
			if(this._modX != value){
				this._modX = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get modY():Number{
			return this._modY;
		}
		public function set modY(value:Number):void{
			if(this._modY != value){
				this._modY = value;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get gridXs():Array{
			return [uint((this._modX - 5) / MapModel.BLOCK_WIDTH),uint((this._modX + 5) / MapModel.BLOCK_WIDTH)];
		}
		public function get gridYs():Array{
			return [uint((this._modY - 5) / MapModel.BLOCK_WIDTH),uint((this._modY + 5) / MapModel.BLOCK_WIDTH)];
		}
		public function get gridX():uint{
			return this._modX / MapModel.BLOCK_WIDTH;
		}
		public function get gridY():uint{
			return this._modY / MapModel.BLOCK_WIDTH;
		}
		public function get dir():uint{
			return this._dir;
		}
		public function set dir(value:uint):void{
			this._dir = value;
			if(this._dir != oldDir){
				oldDir = this._dir;
				dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
			}
		}
		public function get oldDir():uint{
			return this._oldDir;
		}
		public function set oldDir(value:uint):void{
			_oldDir = value;
		}
	}
}