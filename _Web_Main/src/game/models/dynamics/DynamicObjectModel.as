package  game.models.dynamics
{
	import common.utils.TextTool;
	
	import game.interfaces.IDynamicObjectModel;
	import game.interfaces.IMapModel;
	import game.models.statics.StaticObjectModel;

	public class DynamicObjectModel extends StaticObjectModel implements IDynamicObjectModel
	{
		public var speed:Number;
		public var currentDir:uint;
		public var weight:uint = 3;	//与墙壁的间隙距离
		public var oldModX:Number;
		public var oldModY:Number;
		
		public function DynamicObjectModel()
		{
			super();
		}
		
		/**
		 * 
		 */		
		public function move( mapModel:IMapModel ):void
		{
			if(dir > 8){
				//1下 2右下 3右 4右上 5上 6左上 7左 8左下
				oldModX = modX;
				oldModY = modY;
				if(dir == 8 + 1){
				} else if(dir == 8 + 2){
					modX += 0.7 * speed;
				} else if(dir == 8 + 3){
					modX += 1 * speed;
				} else if(dir == 8 + 4){
					modX += 0.7 * speed;
				} else if(dir == 8 + 5){
				} else if(dir == 8 + 6){
					modX -= 0.7 * speed;
				} else if(dir == 8 + 7){
					modX -= 1 * speed;
				} else if(dir == 8 + 8){
					modX -= 0.7 * speed;
				}
				onHitTestX( mapModel );
				
				if(dir == 8 + 1){
					modY += 1 * speed;
				} else if(dir == 8 + 2){
					modY += 0.7 * speed;
				} else if(dir == 8 + 3){
				} else if(dir == 8 + 4){
					modY -= 0.7 * speed;
				} else if(dir == 8 + 5){
					modY -= 1 * speed;
				} else if(dir == 8 + 6){
					modY -= 0.7 * speed;
				} else if(dir == 8 + 7){
				} else if(dir == 8 + 8){
					modY += 0.7 * speed;
				} 
				onHitTestY( mapModel );
				
				TextTool.setText(0, "x= " + gridX + "   y= " + gridY);
				oldDir = dir;
			} else {
				if(oldDir != dir){
					oldDir = dir;
				}
			}
		}
		/**
		 * 如果碰撞倒退
		 */		
		protected function onHitTestX( mapModel:IMapModel ):void{
			
			if( mapModel.onHitTestGrid( this ) ){
				modX = oldModX
			} 
		}
		/**
		 * 如果碰撞倒退
		 */		
		protected function onHitTestY( mapModel:IMapModel ):void{
			
			if( mapModel.onHitTestGrid( this )){
				modY = oldModY;
			} 
		}
	}
}