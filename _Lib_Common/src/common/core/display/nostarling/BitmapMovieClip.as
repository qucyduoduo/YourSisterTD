package common.core.display.nostarling
{
	import common.core.events.BitmapMovieCilpEvent;
	import common.utils.Counter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.animation.IAnimatable;
	
	public class BitmapMovieClip extends Sprite implements IAnimatable
	{
		protected static const NULL_TEXTURE:BitmapData = new BitmapData(1,1,true,0);
		protected var _animationDisplay:Bitmap;
		protected var _animation:MovieClip;
		protected var _currentActionFrames:Vector.<BitmapData>;
		protected var _currentAction:String; 
		protected var _counter:Counter;
		protected var _currentFrameRate:Number;
		protected var _currentFrame:int;
		protected var _isPlay:Boolean;
		protected var _couldTick:Boolean;
		protected var _threshold:int;
		protected var _finishedStop:Boolean;
		protected var _isFinished:Boolean;
		
		public function BitmapMovieClip(animation:MovieClip, defaultState:String = "all" )
		{
			super();
			_animation = animation;
			_threshold = 255;
			_counter = new Counter();
			
			//初始化第1帧
			_currentFrame = 0
			_animationDisplay = new Bitmap(NULL_TEXTURE);
			switchAction(defaultState);
			addChildAt(_animationDisplay, 0);
//			_animationDisplay.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, onStageEventHandle);
			_couldTick = true;
		}
		
//		public function render(support:RenderSupport, parentAlpha:Number):void
//		{
//		}
		
		public function gotoFrame( index:int , force:Boolean = false ):void
		{
			if( _currentFrame != index || force )
			{
				if( index < totalFrames)
				{
					_currentFrame = index;
					updateFrame();
				}
			}
		}
		
		public function advanceTime(time:Number):void
		{
			if(_couldTick == false || _isPlay == false)
			{
				return;
			}
			
			_counter.tick(time);
			var couldRender:Boolean;
			while(_counter.expired == true) //判断是否距离上一帧渲染后已经过了多帧
			{
				if(checkMotionIsFinished())
				{
					if(_finishedStop == true)
					{
						if(_isFinished == false)
						{
							_isFinished = true;
							stop();
							dispatchEvent(new BitmapMovieCilpEvent(BitmapMovieCilpEvent.MOTION_FINISHED));
						}
						return;
					}
					
					_currentFrame = 0;
				}
				else
				{
					_currentFrame += 1
				}
				couldRender = true;
				_counter.reset(_currentFrameRate);
			}
			
			if(couldRender == true)
			{
				updateFrame();
			}
			
		}
		
		public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
		{
			if(forTouch == true)
			{
				return _animation.hitTestByTPAClipDisplay(this, localPoint);
			}
			else
			{
				return null
			}
		}
		
		public function stop():void
		{
			_isPlay = false;
		}
		
		public function play():void
		{
			_isPlay = true;
			_counter.initialize();
			_counter.reset(_currentFrameRate);
			if(_isFinished == true)
			{
				_isFinished = false;
				_currentFrame = 0;
			}
		}
		
		public function updateAnimation(animation:MovieClip):void
		{
			_animation = animation;
		}
		
		public function clone():BitmapMovieClip
		{
			var clip:BitmapMovieClip = new BitmapMovieClip(_animation);
			if(_couldTick == false)
				clip.stop();
			return clip;
		}
		
		public function switchAction(action:String, force:Boolean = false):Boolean
		{
			if(_currentAction == action && force == false)
			{
				return false
			}
			
			//这里要改成gotoAndStop 并监听 enterframe
			var nextActionFrames:Vector.<BitmapData> = _animation.getAnimation(action);
			var len:int = nextActionFrames.length;
			for(var i:int = 0; i<len; i++)
			{
				if(nextActionFrames[i] == null)
				{
					nextActionFrames.splice(i,1);
					len--;
					i--;
				}
			}
			_currentAction = action;
			
			if(nextActionFrames == null || 
				nextActionFrames.length == 0 )
			{
				trace("try to switch unknow action{"+action+"}!");
				return false
			}
			
			_currentActionFrames = nextActionFrames;
			_currentFrameRate = 1 / _animation.getAnimationFPS(_currentAction);
			_counter.initialize();
			_counter.reset(_currentFrameRate);
			_isFinished = false;
			initNextAction(action);
			return true;
		}
		
		public function dispose():void
		{
			if(_animationDisplay.parent)
			{
				_animationDisplay.parent.removeChild(_animationDisplay);
				_animationDisplay.bitmapData.dispose();
				_animationDisplay = null;
			}
			_couldTick = false;
		}
		
		protected function initNextAction(action:String):void
		{
			_currentFrame = 0;
			updateFrame();   
		}
		
		protected function checkMotionIsFinished():Boolean
		{
			if(_currentFrame+1 >= _currentActionFrames.length)
			{
				return true
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 更新帧 
		 */
		protected function updateFrame():void
		{
			
			if(_currentActionFrames.length == 0 || _currentActionFrames[_currentFrame] == null)
			{
				_animationDisplay.bitmapData = NULL_TEXTURE;
				_animationDisplay.x = 0;
				_animationDisplay.y = 0;
				dispatchEvent(new BitmapMovieCilpEvent(BitmapMovieCilpEvent.EMPTY_FRAME));
			}
			else
			{
				var actionSequence:BitmapData =_currentActionFrames[_currentFrame];
				_animationDisplay.bitmapData = actionSequence;
			}
			
			dispatchEvent(new BitmapMovieCilpEvent(BitmapMovieCilpEvent.MOTION_NEXT_FRAME));
		}
		
		protected function onAddToStage():void { }
		
		protected function onRemovedFromStage():void  { }
		
		private function onStageEventHandle(e:Event = null):void
		{
			switch(e.type)
			{
				case Event.REMOVED_FROM_STAGE:
				{
					removeEventListener(Event.REMOVED_FROM_STAGE, onStageEventHandle);
					addEventListener(Event.ADDED_TO_STAGE, onStageEventHandle);
					
					onRemovedFromStage();
					break;
				}
					
				case Event.ADDED_TO_STAGE:
				{
					removeEventListener(Event.ADDED_TO_STAGE, onStageEventHandle);
					addEventListener(Event.REMOVED_FROM_STAGE, onStageEventHandle);
					onAddToStage();
					break;
				}
			}
		}
		
		/**
		 * 动作结束时停止
		 */        
		public function set finishedStop(value:Boolean):void
		{
			_finishedStop = value;
		}
		public function get finishedStop():Boolean
		{
			return _finishedStop;
		}
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		public function set currentFrame(value:int):void
		{
			_currentFrame = value;
			var totalFrames:int = _currentActionFrames.length;
			if(value < 0)
			{
				_currentFrame = 0;
			}
			else if(value < totalFrames)
			{
				_currentFrame = value;
			}
			else
			{
				_currentFrame = totalFrames-1;
			}
		}
		
		public function get totalFrames():int
		{
			return _currentActionFrames.length;
		}
		
		public function get action():String { return _currentAction; }
		
		public function get actionList():Vector.<String>
		{
			return _animation.actonListIndex;
		}
		
		public function get currentTexture():BitmapData
		{
			return _animationDisplay.bitmapData;
		}
		
		public function get animationDisplay():Bitmap
		{
			return _animationDisplay;
		}
		
		public function get threshold():int
		{
			return _threshold;
		}
		
		public function get couldTick():Boolean
		{
			return _couldTick;
		}
	}
}