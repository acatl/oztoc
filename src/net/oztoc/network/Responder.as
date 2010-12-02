package net.oztoc.network
{
    import mx.rpc.IResponder;

    public class Responder implements IResponder
    {
        public function Responder(result:Function=null, fault:Function=null)
        {
            _resultHandler=result;
            _faultHandler=fault;
        }

        public function result(data:Object):void
        {
            if (_resultHandler != null)
                _resultHandler(data);
        }

        public function fault(info:Object):void
        {
            if (_faultHandler != null)
                _faultHandler(info);
        }

        /**
         *  @private
         */
        private var _resultHandler:Function;

        /**
         *  @private
         */
        private var _faultHandler:Function;

    }
}