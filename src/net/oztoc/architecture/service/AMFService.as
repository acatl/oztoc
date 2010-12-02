package net.oztoc.architecture.service
{
	import net.oztoc.remote.AMFConnection;
	
	public class AMFService
	{
		private var remoteClass:String;
		private var services:Services;
		private var gateway:String;
		
		public function AMFService(remoteClass:String, gateway:String, services:Services)
		{
			this.services = services;
			this.gateway = gateway;
			this.remoteClass;
		}

        public function addService(id:String, remoteMethod:String):void
        {
        	services.addService(id,AMFConnection,{gateway: gateway, remoteClass: remoteClass, method: remoteMethod});
        }

	}
}