package  game.base.models
{
	import game.base.interfaces.IDynamicUnitModel;
	import game.core.interfaces.model.IMapModel;

	public class DynamicUnitModel extends StaticUnitModel implements IDynamicUnitModel
	{
		private var _speed:Number;
		
		public function get speed():Number
		{
			return _speed;
		}
		public function set speed( value:Number ):void
		{
			_speed = value;;
		}
		public function DynamicUnitModel()
		{
			super();
		}
		
		/**
		 * 
		 */		
		public function move( mapModel:IMapModel ):void
		{
//			if(dir > 8){
//				//1下 2右下 3右 4右上 5上 6左上 7左 8左下
//				_oldX = x;
//				_oldY = y;
//				if(dir == 8 + 1){
//				} else if(dir == 8 + 2){
//					x += 0.7 * _speed;
//				} else if(dir == 8 + 3){
//					x += 1 * _speed;
//				} else if(dir == 8 + 4){
//					x += 0.7 * _speed;
//				} else if(dir == 8 + 5){
//				} else if(dir == 8 + 6){
//					x -= 0.7 * _speed;
//				} else if(dir == 8 + 7){
//					x -= 1 * _speed;
//				} else if(dir == 8 + 8){
//					x -= 0.7 * _speed;
//				}
//				onHitTestX( mapModel );
//				
//				if(dir == 8 + 1){
//					y += 1 * _speed;
//				} else if(dir == 8 + 2){
//					y += 0.7 * _speed;
//				} else if(dir == 8 + 3){
//				} else if(dir == 8 + 4){
//					y -= 0.7 * _speed;
//				} else if(dir == 8 + 5){
//					y -= 1 * _speed;
//				} else if(dir == 8 + 6){
//					y -= 0.7 * _speed;
//				} else if(dir == 8 + 7){
//				} else if(dir == 8 + 8){
//					y += 0.7 * _speed;
//				} 
//				onHitTestY( mapModel );
//				_oldDir = dir;
//			} else {
//				if(_oldDir != dir){
//					_oldDir = dir;
//				}
//			}
		}
	}
}