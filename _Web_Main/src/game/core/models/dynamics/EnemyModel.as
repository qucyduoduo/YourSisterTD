package game.core.models.dynamics
{
	import game.core.interfaces.model.ICharacterModel;
	import game.base.models.DynamicUnitModel;
	
	public class EnemyModel extends DynamicUnitModel implements ICharacterModel
	{
		protected var _isGCD:Boolean;
		
		protected var _isAniPlaying:Boolean = false;
		public static var heated:Object;
		
		public function set isAniPlaying(value:Boolean):void{
			this._isAniPlaying = value;
		}
		public function get isAniPlaying():Boolean{
			return _isAniPlaying;
		}
		
		public function get isGCD():Boolean{
			return this._isGCD;
		}
		public function set isGCD(value:Boolean):void{
			this._isGCD = value;
		}
		public function EnemyModel() {
			super();
		}
	}
}