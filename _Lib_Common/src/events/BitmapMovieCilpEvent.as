package  events
{
	import flash.events.Event;

    public class BitmapMovieCilpEvent extends Event
    {
        
        public static const MOTION_FINISHED:String = "bitmap_motionFinish";
        public static const MOTION_NEXT_FRAME:String = "bitmap_nextFrame";
        public static const EMPTY_FRAME:String = "bitmap_emtypFrame";
        public function BitmapMovieCilpEvent(type:String, bubbles:Boolean=false, data:Object=null)
        {
            super(type, bubbles, data);
        }
    }
}