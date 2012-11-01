package debug
{
    public class Debugger
    {
        protected var _outputFunc:Function;
        public function Debugger()
        {
            _outputFunc = output;
        }
        public function log(...params):void
        {
            params.unshift("===[[LOG]]===");
            _outputFunc.apply (null, params);
        }
        
        public function serverLog(...params):void
        {
            _outputFunc.apply (null, params);
        }
        
        private function output(...params):void
        {
            trace("Debugger:"+params);
        }   
    }
}