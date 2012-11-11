package common.core.display.starling
{
    import common.core.events.starling.TPMovieClipEvent;
    import common.utils.Counter;
    
    import flash.display.BitmapData;
    import flash.geom.Point;
    
    import starling.animation.IAnimatable;
    import starling.core.RenderSupport;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    
    /**
     * TexturePacker剪辑 
     * @author LepoZuk_2012_Uqee
     * 对tpa文件的一个starling还原
     */
    public class TPMovieClip extends Sprite implements IAnimatable
    {
        /**
         * 当没有贴图时使用的贴图 
         */        
        protected static const NULL_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1,1,true,0));
        
        /**
         * tpa导出文件序列显示区域
         */  
        protected var _animationDisplay:FrameImage;
        
        /**
         * tpa文件解析器
         */        
        protected var _animation:TPAnimation;
        
        /**
         * 当前动作动画序列 
         */        
        protected var _currentActionFrames:Vector.<TPSequence>;
        
        /**
         * 当前动作 
         */        
        protected var _currentAction:String; 
        
        /**
         * 动画计数器
         */        
        protected var _counter:Counter;

        /**
         * 当前动画帧频
         */        
        protected var _currentFrameRate:Number;
        
        /**
         * 当前动画帧
         */        
        protected var _currentFrame:int;
        
        protected var _isPlay:Boolean;
        
        protected var _couldTick:Boolean;
        
        /**
         * 鼠标可以检测到的颜色阀值
         */        
        protected var _threshold:int;
        
        /**
         * 动作完成后停止
         */        
        protected var _motionFinishedStop:Boolean;
        
        /**
         * 动作已经结束了
         */        
        protected var _motionIsFinished:Boolean;
        
        /**
         * 是否已经释放
         */        
        protected var _isDisposed:Boolean;
        
        /**
         * 构造 
         * @param animation             tpa动画解析
         * @param defaultState          默认状态
         */        
        public function TPMovieClip(animation:TPAnimation, defaultState:String = "all")
        {
            super();
            _animation = animation;
            _threshold = 255;
            _counter = new Counter();
            
            //初始化第1帧
            _currentFrame = 0
            _animationDisplay = new FrameImage(NULL_TEXTURE);
            switchAction(defaultState);
            addChildAt(_animationDisplay, 0);
            _animationDisplay.touchable = false;
            addEventListener(Event.ADDED_TO_STAGE, onStageEventHandle);
            _couldTick = true;
        }
        
        override public function render(support:RenderSupport, parentAlpha:Number):void
        {
            super.render(support, parentAlpha);
        }
        
		/**
		 *
		 * 跳转帧 
		 * @param index
		 * 
		 */		
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
                    if(_motionFinishedStop == true)
                    {
                        if(_motionIsFinished == false)
                        {
                            _motionIsFinished = true;
                            stop();
                            dispatchEvent(new TPMovieClipEvent(TPMovieClipEvent.MOTION_FINISHED));
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
        
        override public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
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
        
        /**
         * 停止动画 
         */        
        public function stop():void
        {
            _isPlay = false;
        }
        
        /**
         * 动画播放 
         */        
        public function play():void
        {
            _isPlay = true;
            _counter.initialize();
            _counter.reset(_currentFrameRate);
            if(_motionIsFinished == true)
            {
                _motionIsFinished = false;
                _currentFrame = 0;
            }
        }
        
        public function updateAnimation(animation:TPAnimation):void
        {
            _animation = animation;
        }
        
        /**
         * 复制一个tpa剪辑对象 
         * @return 复制的剪辑对象
         */        
        public function clone():TPMovieClip
        {
            var clip:TPMovieClip = new TPMovieClip(_animation);
            if(_couldTick == false)
                clip.stop();
            return clip;
        }
        
        /**
         * 切换动作
         * 切换后从第一帧开始播放
         * @param action    动作
         * @param force     (default = false)强制执行
         */        
        public function switchAction(action:String, force:Boolean = false):Boolean
        {
            if(_currentAction == action && force == false)
            {
                return false
            }
            
            var nextActionFrames:Vector.<TPSequence> = _animation.getAnimation(action);
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
            _motionIsFinished = false;
            initNextAction(action);
            return true;
        }
        
        override public function dispose():void
        {
            if(_isDisposed == false)
            {
                _isDisposed = true;
                distruct();
            }
        }
        
        protected function distruct():void
        {
            _animationDisplay.removeFromParent(true);
            _animationDisplay = null;
            _couldTick = false;
            super.dispose();
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
                _animationDisplay.texture = NULL_TEXTURE;
                _animationDisplay.x = 0;
                _animationDisplay.y = 0;
                dispatchEvent(new TPMovieClipEvent(TPMovieClipEvent.EMPTY_FRAME));
            }
            else
            {
                var actionSequence:TPSequence =_currentActionFrames[_currentFrame];
                _animationDisplay.texture = actionSequence.texture;
                var offset:Point = actionSequence.offset;
                _animationDisplay.pivotX = offset.x;
                _animationDisplay.pivotY = offset.y;
            }
            
            dispatchEvent(new TPMovieClipEvent(TPMovieClipEvent.MOTION_NEXT_FRAME));
            _animationDisplay.readjustSize();
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
        public function set motionFinishedStop(value:Boolean):void
        {
            _motionFinishedStop = value;
        }
        public function get motionFinishedStop():Boolean
        {
            return _motionFinishedStop
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
        
        /**
         * 当前动作 
         */
        public function get action():String { return _currentAction; }
        
        public function get actionList():Vector.<String>
        {
            return _animation.actonListIndex;
        }
        
        /**
         * 给tpa区域一个颜色
         */        
        public function get color():uint { return _animationDisplay.color; }
        public function set color(value:uint):void
        {
            _animationDisplay.color = value;
        }
        
        public function get currentTexture():Texture
        {
            return _animationDisplay.texture;
        }
        
        /**
         * tpa动画显示区域 
         */
        public function get animationDisplay():FrameImage
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
        
        public function get isDisposed():Boolean
        {
            return _isDisposed;
        }
    }
}