package game.core.models.dynamics
{
	import game.core.interfaces.IPeopleModel;
	
	public class MonsterModel extends DynamicObjectModel implements IPeopleModel
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
		/**
		 * 被攻击判定
		 * @param model
		 */		
		public function heated( model:* ):void{
			if(model is IPeopleModel){
				trace ( "[MonsterModel] " + (model as IPeopleModel).dir );
				//对八方向分别进行攻击判定
				if(model.dir % 8 == 1){
					modY += 6;
				} else if(model.dir % 8 == 2){
					modX += 3;
					modY += 3;
				} else if(model.dir % 8 == 3){
					modX += 6;
				} else if(model.dir % 8 == 4){
					modX += 3;
					modY -= 3;
				} else if(model.dir % 8 == 5){
					modY -= 6;
				} else if(model.dir % 8 == 6){
					modX -= 3;
					modY -= 3;
				} else if(model.dir % 8 == 7){
					modX -= 6;
				} else if(model.dir % 8 == 0){
					modX -= 3;
					modY += 3;
				} 
			}
		}
		
		public function MonsterModel() {
			super();
		}
	}
}