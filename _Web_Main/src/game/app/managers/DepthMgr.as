package  game.app.managers
{
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	/**
	 * 显示对象排序管理器 
	 * @author noah
	 * 
	 */	
    public class DepthMgr {

        private static var managers:Dictionary;

        private var depths:Dictionary;

        public function DepthMgr(){
            super();
            this.depths = new Dictionary(true);
        }
		
		/**
		 * 取得某个容器对应的深度管理的实例类 
		 * @param container
		 * @return 
		 * 
		 */		
        public static function getManager(container:DisplayObjectContainer):DepthMgr{
            if (!managers){
                managers = new Dictionary(true);
            };
            var m:DepthMgr = managers[container];
            if (!m){
                m = new DepthMgr();
                managers[container] = m;
            };
            return m;
        }
		
		/**
		 * 调整child的深度层次 
		 * @param child
		 * @param depth
		 * @return 
		 * 
		 */		
        public static function swapDepth(child:DisplayObject, depth:Number):int{
            return getManager(child.parent).swapChildDepth(child, depth);
        }
		
		/**
		 * 排列该容器下所有的显示列表，按y轴值来排 
		 * @param doc
		 * 
		 */		
        public static function swapDepthAll(doc:DisplayObjectContainer,fieldName:String):void{
            var dm:* = null;
            var child:* = null;
            var i:* = 0;
            var doc:* = doc;
            dm = getManager(doc);
            var len:* = doc.numChildren;
            var arr:* = [];
            i = 0;
            while (i < len) {
                child = doc.getChildAt(i);
                arr.push(child);
                i = (i + 1);
            }
            arr.sortOn(fieldName, Array.NUMERIC);
            arr.forEach(function (item:DisplayObject, index:int, array:Array):void{
                doc.setChildIndex(item, index);
                dm.setDepth(item, item[fieldName]);
            })
            arr = null;
        }
		
		/**
		 * 析构该容器下的深度管理类 
		 * @param container
		 * 
		 */		
        public static function clear(container:DisplayObjectContainer):void{
            delete managers[container];
        }
		
		/**
		 * 清空所有的深度管理类 
		 * 
		 */		
        public static function clearAll():void{
            managers = null;
        }
		
		/**
		 * 移植到底层 
		 * @param mc
		 * 
		 */		
        public static function bringToBottom(mc:DisplayObject):void{
            var parent:DisplayObjectContainer = mc.parent;
            if (parent == null){
                return;
            };
            if (parent.getChildIndex(mc) != 0){
                parent.setChildIndex(mc, 0);
            };
        }
		
		/**
		 * 移植到顶层 
		 * @param mc
		 * 
		 */		
        public static function bringToTop(mc:DisplayObject):void{
            var parent:DisplayObjectContainer = mc.parent;
            if (parent == null){
                return;
            };
            parent.addChild(mc);
        }
		
		/**
		 * 取得该对象的深度层次 
		 * @param child
		 * @return 
		 * 
		 */		
        public function getDepth(child:DisplayObject):Number{
            if (this.depths[child] == null){
                return this.countDepth(child, child.parent.getChildIndex(child), 0);
            };
            return this.depths[child];
        }
		
		/**
		 * 
		 * @param child
		 * @param index
		 * @param n
		 * @return 
		 * 
		 */		
        private function countDepth(child:DisplayObject, index:int, n:Number=0):Number{
            if (this.depths[child] == null){
                if (index == 0){
                    return 0;
                };
                return this.countDepth(child.parent.getChildAt((index - 1)), (index - 1), (n + 1));
            };
            return this.depths[child] + n;
        }
        public function setDepth(child:DisplayObject, d:Number):void{
            this.depths[child] = d;
        }
		
		/**
		 * 排序该对象的深度层次 
		 * @param child
		 * @param depth
		 * @return 
		 * 
		 */		
        public function swapChildDepth(child:DisplayObject, depth:Number):int{
            var mid:int;
            var midDepth:Number;
            var container:DisplayObjectContainer = child.parent;
            if (container == null){
                throw new Error("child is not in a container!!");
            };
            var index:int = container.getChildIndex(child);
            var oldDepth:Number = this.getDepth(child);
            if (depth == oldDepth){
                this.setDepth(child, depth);
                return index;
            };
            var n:int = container.numChildren;
            if (n < 2){
                this.setDepth(child, depth);
                return index;
            };
            if (depth < this.getDepth(container.getChildAt(0))){
                container.setChildIndex(child, 0);
                this.setDepth(child, depth);
                return 0;
            };
            if (depth >= this.getDepth(container.getChildAt((n - 1)))){
                container.setChildIndex(child, (n - 1));
                this.setDepth(child, depth);
                return n - 1;
            };
            var left:int;
            var right:int = (n - 1);
            if (depth > oldDepth){
                left = index;
                right = (n - 1);
            } else {
                left = 0;
                right = index;
            };
            while (right > (left + 1)) {
                mid = (left + ((right - left) / 2));
                midDepth = this.getDepth(container.getChildAt(mid));
                if (midDepth > depth){
                    right = mid;
                } else {
                    if (midDepth < depth){
                        left = mid;
                    } else {
                        container.setChildIndex(child, mid);
                        this.setDepth(child, depth);
                        return mid;
                    };
                };
            };
            var leftDepth:Number = this.getDepth(container.getChildAt(left));
            var rightDepth:Number = this.getDepth(container.getChildAt(right));
            var destIndex:int;
            if (depth >= rightDepth){
                if (index <= right){
                    destIndex = Math.min(right, (n - 1));
                } else {
                    destIndex = Math.min((right + 1), (n - 1));
                };
            } else {
                if (depth < leftDepth){
                    if (index < left){
                        destIndex = Math.max((left - 1), 0);
                    } else {
                        destIndex = left;
                    };
                } else {
                    if (index <= left){
                        destIndex = left;
                    } else {
                        destIndex = Math.min((left + 1), (n - 1));
                    };
                };
            };
            container.setChildIndex(child, destIndex);
            this.setDepth(child, depth);
            return destIndex;
        }

    }
}