package  common.core.events.starling
{
    import flash.events.Event;
    
    public class TPAnimationEvent extends Event
    {
        public static const INITIALIZED:String = "tp_initialized";
        
        public function TPAnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
    }
}