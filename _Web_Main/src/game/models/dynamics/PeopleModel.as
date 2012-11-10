package  game.models.dynamics
{
	import game.events.ActionEvent;
	import game.interfaces.IDynamicObjectModel;
	import game.interfaces.IMapView;
	import game.interfaces.IPeopleModel;
	import game.managers.BattleMgr;

	/**
	 * 人物模型
	 * @author noah
	 */	
	public class PeopleModel extends DynamicObjectModel implements IPeopleModel,IDynamicObjectModel
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
		
		public function PeopleModel()
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