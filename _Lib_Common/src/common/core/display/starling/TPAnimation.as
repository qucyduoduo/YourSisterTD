package common.core.display.starling 
{
    import common.core.events.starling.TPAnimationEvent;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.system.ImageDecodingPolicy;
    import flash.system.LoaderContext;
    import flash.system.System;
    import flash.utils.ByteArray;
    
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.textures.SubTexture;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    
    public class TPAnimation extends EventDispatcher
    {
        /**
         * 待解析的alpha通道序列
         */        
        private var _remainAlphaChannelDatas:Vector.<ByteArray>;
        
        /**
         * 待解析的配置序列 
         */        
        private var _remainTextureSettingAnimation:Vector.<String>;
        
        /**
         * ATF数据列表
         */        
        private var _atfDatasList:Vector.<ByteArray>;
        
        /**
         * texture atlas的透明度列表
         */        
        private var _textureCollideList:Vector.<BitmapData>;
        
        /**
         * texture atlas的贴图列表
         */        
        private var _textureList:Vector.<Texture>;
        
        /**
         * textureAtlas的列表
         */        
        private var _textureAtlasList:Vector.<TextureAtlas>;
        /**
         *  贴图索引
         */        
        private var _textureNameSet:Vector.<Vector.<String>>;
        
        /**
         * textureAtlas的配置
         */        
        private var _textureAtlasSettingList:Vector.<XML>;
        
        /**
         * 动作序列数据列表 
         */        
        private var _sequenceList:Vector.<Vector.<SequenceData>>;
        
        /**
         * 动作序列索引
         */        
        private var _actionIndex:Vector.<String>;
        
        /**
         * 帧序列何位置偏移列表
         */        
        private var _textureOffsetList:Vector.<Point>;
        
        /**
         * 帧序列何位置偏移索引
         */        
        private var _textureOffsetIndex:Vector.<String>;
        
        /**
         * alpha通道图载入器
         */        
        private var _alphaLoader:Loader;
        
        /**
         * 是否已经释放
         */        
        private var _isDisposed:Boolean;
        
        /**
         * 判断可点区域的透明度
         * 范围是0~255
         */        
        private var _threshold:int;
        
        /**
         * 动作fps列表
         */
        private var _actionFPSList:Vector.<int>;
        
        private var _tpaId:String;
        
        /**
         * 构造
         * @param threshold        (默认值255)判断可点区域的透明度, 范围是0~255
         */        
        public function TPAnimation(id:String = "", threshold:int=255)
        {
            _tpaId = id;
            _threshold = threshold;
            if(_threshold>255)
            {
                threshold = 255;
            }
            else if(_threshold<0)
            {
                _threshold = 0;
            }
        }
        
        /**
         * 解析tpa文件 
         * @param data      tpa文件字节流
         */        
        public function decode(data:ByteArray):void
        {
            data.inflate();
            
            var animation:XML = XML(decodeURI(data.readUTFBytes(data.readUnsignedInt())));
            
            var compressData:ByteArray = new ByteArray();
            
            data.readBytes(compressData, 0, data.readInt());
            
            compressData.inflate();
            
            var len:int = compressData.readByte();
            
            _actionIndex = new Vector.<String>();
            _actionFPSList = new Vector.<int>();
            _sequenceList = new Vector.<Vector.<SequenceData>>();
            _textureNameSet = new Vector.<Vector.<String>>();
            _textureCollideList = new Vector.<BitmapData>();
            
            _atfDatasList = new Vector.<ByteArray>(len);
            _textureList = new Vector.<Texture>(len);
            _textureAtlasList = new Vector.<TextureAtlas>(len);
            _remainAlphaChannelDatas = new Vector.<ByteArray>(len);
            _remainTextureSettingAnimation = new Vector.<String>(len);
            
            var nodeData:ByteArray;
            
            for(var i:int = 0; i<len; i++)
            {
                nodeData = new ByteArray()//alpha channel (bytearray)
                compressData.readBytes(nodeData, 0, compressData.readInt()); 
                _remainAlphaChannelDatas[i] = nodeData;
                
                nodeData = new ByteArray()//atf data (bytearray)
                compressData.readBytes(nodeData, 0, compressData.readInt()); 
                _atfDatasList[i] = nodeData;
                
                _remainTextureSettingAnimation[i] = decodeURI(compressData.readUTFBytes(compressData.readInt()));
            }
            
            ///start init animation sequences//////////////////////////////////////////
            var actionList:XMLList = animation.action;
            var sequenceList:XMLList;
            var action:XML;
            var sequenceCollection:Vector.<SequenceData>;
            var sequence:XML;
            var j:int;
            var k:int
            
            
            len = actionList.length();
            
            for(i = 0; i<len; i++)
            {
                action = actionList[i]
                sequenceList = action.sequence;
                k = sequenceList.length();
                sequenceCollection = createAction(action.@id, action.@fps);
                
                for(j = 0; j<k; j++)
                {
                    sequence = sequenceList[j];
                    sequenceCollection.push(new SequenceData(sequence.@source, int(sequence.@frame)));
                }
            }
            
            sequenceCollection = null;
            System.disposeXML(animation);
            
            len = _sequenceList.length;
            for(i = 0; i<len; i++)
            {
                _sequenceList[i].sort(sortSequence);
            }
            
            ///end init animation sequences//////////////////////////////////////////
            _textureOffsetIndex = new Vector.<String>();
            _textureOffsetList = new Vector.<Point>();
            _textureAtlasSettingList = new Vector.<XML>();
            
            startPrepareNextCollideData();
            
        }
        
        /**
         * 切换序列动作列表
         * @param actionName        动作名
         * @return                  目标序列动作列表
         */        
        protected function createAction(actionName:String, fps:int):Vector.<SequenceData>
        {
            var index:int = _actionIndex.indexOf(actionName);
            if(index < 0)
            {
                var sequenceCollection:Vector.<SequenceData> = new Vector.<SequenceData>();
                _actionIndex.push(actionName);
                _actionFPSList.push(fps);
                _sequenceList.push(sequenceCollection);
                
                return sequenceCollection
            }
            
            return _sequenceList[index];
        }
        
        /**
         * 按帧数字顺排序帧序列
         * @param sequenceA     序列帧A
         * @param sequenceB     序列帧B
         * @return 
         */        
        protected function sortSequence(sequenceA:SequenceData, sequenceB:SequenceData):Number
        {
            return sequenceA.frame - sequenceB.frame;
        }
        /**
         * 开始准备下一组动画贴图 
         */        
        protected function startPrepareNextCollideData():void
        {
            if(_remainAlphaChannelDatas.length == 0 ||
                _remainAlphaChannelDatas.length == 0 ||
                _remainAlphaChannelDatas.length == 0)
            {
                dispatchEvent(new TPAnimationEvent(TPAnimationEvent.INITIALIZED));
                return;
            }
            
            _alphaLoader = new Loader();
            _alphaLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, prepareTextureData);
            var loaderContext:LoaderContext = new LoaderContext();
            loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            _alphaLoader.loadBytes(_remainAlphaChannelDatas[0], loaderContext);
        }
        
        protected function prepareTextureData(e:Event):void
        {
            _alphaLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, prepareTextureData);
            var alphaData:BitmapData = (_alphaLoader.content as Bitmap).bitmapData;//复制出来为使用时检查碰撞使用
//            if(Capabilities.isDebugger == true)
//            {
//                trace("tpa["+_tpaId+"] alpha collide data (use transparent? "+alphaData.transparent+") size:", alphaData.width+"x"+alphaData.height,"occur "+(alphaData.width*alphaData.height*6)+" bytes");
//            }
            _textureCollideList.push(alphaData.clone());
            _alphaLoader.unloadAndStop();
            _alphaLoader = null;
            
            //parse subtexture setting;
            var sourceSetting:XML = XML(_remainTextureSettingAnimation[0]);
            var sourceAssetWidth:int = int(sourceSetting.@width)*.5;
            var sourceAssetHeight:int = int(sourceSetting.@height)*.5;
            var sourceList:XMLList = sourceSetting.sequence;
            
            var atlasSetting:XML = XML(<altasSetting></altasSetting>);
            var sequenceSetting:XML;
            var subTexture:XML;
            var len:int = sourceList.length();
            
            var textureOffsetList:Vector.<Point> = new Vector.<Point>(len);
            var textureOffsetIndex:Vector.<String> = new Vector.<String>(len);
            var subTextureName:String;
            var textureOffsetPoint:Point;
            var textureNameList:Vector.<String> = new Vector.<String>(len);
            
            for(var i:int = 0; i<len; i++)
            {
                sequenceSetting = sourceList[i];
                subTexture = XML(<SubTexture />);
                
                subTextureName = sequenceSetting.@name;
                subTexture.@name = subTextureName
                subTexture.@width = sequenceSetting.@width;
                subTexture.@height = sequenceSetting.@height;
                subTexture.@x = sequenceSetting.@x;
                subTexture.@y = sequenceSetting.@y;
                textureOffsetPoint = new Point(sourceAssetWidth-int(sequenceSetting.@xOffset),sourceAssetHeight-int(sequenceSetting.@yOffset));
                
                subTexture.@frameX = 0;
                subTexture.@frameY = 0;
                subTexture.@frameWidth = sequenceSetting.@width;
                subTexture.@frameHeight = sequenceSetting.@height;
                
                textureNameList[i] = subTextureName;
                textureOffsetList[i] = textureOffsetPoint;
                textureOffsetIndex[i] = subTextureName;
                atlasSetting.appendChild(subTexture);
            }
            
            //保存贴图配置数据
            _textureOffsetIndex = _textureOffsetIndex.concat(textureOffsetIndex);
            _textureOffsetList = _textureOffsetList.concat(textureOffsetList);
            _textureAtlasSettingList.push(atlasSetting);
            _textureNameSet.push(textureNameList);
            
            System.disposeXML(subTexture);
            System.disposeXML(sourceSetting);
            
            _remainAlphaChannelDatas.splice(0,1)[0].clear();
            _remainTextureSettingAnimation.splice(0,1);
            
            startPrepareNextCollideData();
        }
        
        /**
         * 获得目标动作的帧频 
         * @param action        目标动作
         * @return              帧频
         */        
        public function getAnimationFPS(action:String):int
        {
            var index:int = _actionIndex.indexOf(action);
            var fps:int;
            if(index<0)
            {
                fps =  8;
            }
            else
            {
                fps = _actionFPSList[index]
            }
            
//            trace("getAnimationFPS{"+action+"}:", fps);
            return fps; 
        }
        
        /**
         * 取动画序列 
         * @param action        目标动作(all为全部动画)
         * @return              动画序列
         */        
        public function getAnimation(action:String):Vector.<TPSequence>
        {
            var returnList:Vector.<TPSequence> = new Vector.<TPSequence>();
            
            if(action == "all")
            {
                var jLen:int = _actionIndex.length;
                for(var j:int = 0; j<jLen; j++)
                {
                    returnList = returnList.concat(getAnimation(_actionIndex[j]));
                }
                
                return returnList;
            }
            
            var index:int = _actionIndex.indexOf(action);
            if(index<0)
            {
                return null;
            }
            
            var sequenceList:Vector.<SequenceData> = _sequenceList[index];
            var len:int = sequenceList.length;
            var sourceName:String;
            for(var i:int = 0; i<len; i++)
            {
                sourceName = sequenceList[i].source;
                returnList[i] = getTextureByName(sourceName);
            }
            
            return returnList;
        }
        
        /**
         * 根据序列帧名取贴图 
         * @param name      序列帧名
         * @return          目标贴图,如果找不到则返回空
         */        
        protected function getTextureByName(name:String):TPSequence
        {
            if(name == "")
            {
                return null;
            }
            var findTexture:Boolean;
            var len:int = _textureNameSet.length;
            for(var i:int = 0; i<len;i++)
            {
                if(_textureNameSet[i].indexOf(name)<0)
                {
                    continue;   
                }
                findTexture = true;
                break
            }
            
            if(findTexture == false)
            {
                return null;
            }
            
            var texture:Texture;
            var textureAtlas:TextureAtlas;
            textureAtlas = _textureAtlasList[i];
            if(textureAtlas == null)
            {
//                var time:uint = getTimer(); 
                texture = Texture.fromAtfData(_atfDatasList[i]);
//                if(Capabilities.isDebugger == true)
//                {
//                    trace("tpa["+_tpaId+"] upload textureAtlas no."+(i+1)+" clips use time: "+(getTimer()-time)+"ms");
//                }
                textureAtlas = new TextureAtlas(texture, _textureAtlasSettingList[i]);
                _textureAtlasList[i] = textureAtlas;
                _textureList[i] = texture;
            }
                
            texture = textureAtlas.getTexture(name);
            
            if(texture != null)
            {
                return new TPSequence(texture, _textureOffsetList[_textureOffsetIndex.indexOf(name)]);
            }
            
            return null;
        }
        
        /**
         * 检测TPCClip是不是可以被点到
         * @param clip          TPMovieClip对象
         * @param localPoint    检测点
         * @return              如果可以点到返回TPMovieClip对象否则返回null
         */        
        internal function hitTestByTPAClipDisplay(clip:TPMovieClip,  localPoint:Point):DisplayObject
        {
            var display:Image = clip.animationDisplay;//取到显示对象的tp序列显示容器
            if(display == null)
            {
                trace("found null display");
                return null;
            }
            
            var subTexture:SubTexture = display.texture as SubTexture;  //取到显示容器中的当前贴图
            var index:int;
            if(subTexture == null || (index = _textureList.indexOf(subTexture.parent))<0)
            {
                return null;
            }
            
            var collideData:BitmapData = _textureCollideList[index];
            var frameRect:Rectangle = subTexture.frame;
            var clipRect:Rectangle = subTexture.clipping;
            
            var collideAreaWidth:Number = subTexture.width/clipRect.width;
            var collideAreaHeight:Number = subTexture.height/clipRect.height;
            
            var renderArea:Rectangle = new Rectangle(0,0,subTexture.width,subTexture.height);
            var mousePoint:Point = new Point(display.pivotX+localPoint.x, display.pivotY+localPoint.y);
            
            if(renderArea.containsPoint(mousePoint)) 
            {
                var color:uint =collideData.getPixel(collideAreaWidth*clipRect.x + mousePoint.x, collideAreaHeight*clipRect.y + mousePoint.y)
                color = (color>>16)&255;
                
                if(color >= _threshold)
                {
                    return clip;
                }
            }
            return null
        }
        
        /**
         * 释放 
         */        
        public function dispose():void
        {
            if(_isDisposed == false)
            {
                _isDisposed = true;
				distruct();
            }
        }
		/**
		 * 释放显存中的贴图
		 */		
		public function disposeTexture():void
		{
			var len:int = _textureList.length;  
			for(var i:int =0; i<len; i++)
			{
				if(_textureList[i] != null)
				{
					_textureList[i].dispose();
					_textureList[i] = null;
				}
				
				if(_textureAtlasList[i] != null)
				{
					_textureAtlasList[i].dispose();
					_textureAtlasList[i] = null;
				}
			}
		}
		
		protected function distruct():void
		{
			disposeTexture();
			
			var len:int = _textureCollideList.length;  
			for(var i:int =0; i<len; i++)
			{
				_textureCollideList[i].dispose();
				
				if(_atfDatasList[i] != null)
				{
					_atfDatasList[i].clear();
				}
			}
			
			if(_alphaLoader != null)
			{
				_alphaLoader.unloadAndStop();
			}
			
			_atfDatasList = null;
			_alphaLoader = null;
			_textureCollideList = null;
			_actionIndex = null;
			_sequenceList = null;
		}
        
        /**
         * 动作列表索引
         */
        public function get actonListIndex():Vector.<String>
        {
            return _actionIndex;
        }
    }
}

class SequenceData
{
    private var _action:String;
    private var _source:String;
    private var _frame:int;
    public function SequenceData(source:String, frame:int):void
    {
//        _action = action;
        _source = source;
        _frame = frame;
    }
//    public function get action():String { return _action; }
    public function get source():String { return _source; }
    public function get frame():int { return _frame; }
}