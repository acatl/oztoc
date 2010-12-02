package net.oztoc.architecture.service
{
    import mx.rpc.http.HTTPService;
    
    import net.oztoc.remote.AMFConnection;

    public class ServiceLocator extends Services
    {
        public function ServiceLocator()
        {
            super();
        }

        override public function addService(id:String, service:Class, properties:Object=null):Boolean
        {
            return instance.addService(id, service, properties);
        }
        
        
        override public function removeService(id:String):Boolean
        {
            return instance.removeService(id);
        }
        
        override public function getService(id:String):Object
        {
            return instance.getService(id);
        }
        
        override public function getAMFConnection(id:String):AMFConnection
        {
            return instance.getAMFConnection(id);
        }
        
        override public function getHTTPService(id:String):HTTPService
        {
            return instance.getHTTPService(id);
        }
        

        /**
         * Holds value of the property <code>instance</code>
         **/
        private static var _instance:Services;

        /**
         **/
        public static function get instance():Services
        {
            if (_instance == null)
            {
                _instance=new Services();
            }
            return _instance;
        }

    }
}