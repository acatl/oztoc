package net.oztoc.architecture.service
{
    public class Service
    {
        private var service:Class;
        private var properies:Object;
        
        public function Service(service:Class, properties:Object):void
        {
            this.service = service;
            this.properies = properties;
        }
        
        public function createInstance():Object
        {
            var instance:Object = new this.service();
            for (var prop:String in properies)
            {
                instance[prop] = properies[prop];
            }
            return instance;
        }
    }
}