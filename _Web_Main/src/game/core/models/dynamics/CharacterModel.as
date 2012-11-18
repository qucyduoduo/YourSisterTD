package  game.core.models.dynamics
{
	import game.core.events.ActionEvent;
	import game.base.interfaces.IDynamicUnitModel;
	import game.core.interfaces.view.IMapView;
	import game.core.interfaces.model.ICharacterModel;
	import game.app.managers.BattleMgr;
	import game.base.models.DynamicUnitModel;

	/**
	 * 人物模型
	 * @author noah
	 */	
	public class CharacterModel extends DynamicUnitModel implements ICharacterModel,IDynamicUnitModel
	{
		/**
		 * 是否公共技能冷却中 
		 */		
		protected var _isGCD:Boolean;
		protected var _isAniPlaying:Boolean = false;
		
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
		
		public static var GCD_TIME:uint = 800;
		/**
		 * 临时普通攻击技能 
		 */		
//		public var attackSkill:BaseAttack;
		
		public function heated( model:*):void{
			
		}
		
		public function CharacterModel()
		{
			super();
		}
		
		/**
		 * 攻击
		 * @param map
		 */		
		public function attack(map:IMapView):void {
			
			BattleMgr.instance.attack( this, map );
			dispatchEvent(new ActionEvent( ActionEvent.ATTACK, map ));
		}
		/**
		 * 远程攻击
		 * @param map
		 */		
		public function cast(map:IMapView):void {
			
			BattleMgr.instance.cast( this, map );
			dispatchEvent(new ActionEvent( ActionEvent.ATTACK, map ));
		}
	}
}