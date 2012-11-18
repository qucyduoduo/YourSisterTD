package  game.core.models.dynamics
{
	import game.core.interfaces.IDynamicObjectModel;
	import game.core.interfaces.IMapModel;
	import game.core.models.statics.StaticObjectModel;

	public class DynamicObjectModel extends StaticObjectModel implements IDynamicObjectModel
	{
		private var _speed:Number;
		private var _oldX:Number;
		private var _oldY:Number;
		
		public function DynamicObjectModel()
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