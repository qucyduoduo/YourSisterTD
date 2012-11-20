package panel
{
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ControlsPanel extends Panel
	{
		private var _addWalkBtn:PushButton;
		private var _addBlockBtn:PushButton;
		
		public function ControlsPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			_addWalkBtn = new PushButton( this, 10, 10, "可行走区域", onAddHandler );
			_addBlockBtn = new PushButton( this, 10, 40, "阻挡区域", onAddHandler );
		}
		
		private function onAddHandler( e:MouseEvent ):void
		{
			if( e.currentTarget == _addWalkBtn )
			{
				dispatchEvent(new Event( "addWalk" ));
			}
			else if( e.currentTarget == _addBlockBtn )
			{
				dispatchEvent(new Event( "addBlock" ));
			}
		}
	}
}