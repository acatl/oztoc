/*

	Copyright(c) 2008 Acatl Pacheco
	e-mail:   acatl.pacheco@gmail.com
		
	This file is part of Oztoc.
	
	Oztoc is free software: you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as
	published by the Free Software Foundation, either version 3 of
	the License, or (at your option) any later version.
	
	Oztoc is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU Lesser General Public
	License along with Oztoc. If not, see <http://www.gnu.org/licenses/>.
	
*/


package net.oztoc.architecture.service
{

	import mx.rpc.http.HTTPService;
	
	import net.oztoc.remote.AMFConnection;
	import net.oztoc.utilities.data.Library;
	
	/**
	 * Use this class to add new services to your app. the purpose of it is to have one 
	 * central point of your services. And also it saves Class Objects instead of Class 
	 * Instances,this gives the advantage thatyou can run multimple or the same 
	 * service multiple times. and each service will have its own listeners. This way you 
	 * will not depend on an instance and their reference of its listeners to custom 
	 * handelers that you pass to them.
	 * 
	 * You have essencialy two types of  services, AMF or HTTP, when registering a 
	 * service using the <code>addService</code> you can pass default values for 
	 * the Class so once its created it will assign these values. 
	 * 
	 * @see mx.rpc.http.HTTPService
	 * @see net.oztoc.remote.AMFConnection
	 * */
	public class Services
	{
		/**
		 * Collection of services that where registered with the 
		 * <code>addService</code>.
		 * */
		private var _services:Library;
		
		/**
		 * Constructor
		 * */
		public function Services()
		{
			_services = new Library();
		}
		
		/**
		 * Adds a Service Class Object with a unique identifier that you will later use 
		 * to create a new instance of it. You can add sepcific predefined attributes 
		 * to the Service Class Object using the <code>properties</code> Object 
		 * which is passed as a parameter of this method.
		 * 
		 * @param id Unique identifier for the Service
		 * @param service Service Class Object
		 * @param properties An Object that contains sepcific predefined attributes 
		 * that the Service Class Objectwill use when creating a new instance of it.
		 * 
		 * */
		public function addService(	id:String, service:Class, 
														properties:Object=null):Boolean
		{
			if ( _services.exists(id) ) 
			{
			 	throw new Error("Service already exists");
			 	return false;
			}
			_services.add( id, new Service(service,properties) );
			return true;
		}
		
		/**
		 * Removes a service from the collection.
		 * 
		 * @param id Unique identifier for the Service to be removed
		 * */
		 
		public function removeService(id:String):Boolean
		{
			if ( _services.exists(id) )
			{
				return false;
			}
			_services.remove(id);
			return true;
		}
		
		/**
		 * Gets a service that corresponds to the <code>id</code> passed, creates 
		 * a new instance, assigns its properties adn returns it. 
		 * */
		public function getService(id:String):Object
		{
			if ( !_services.exists(id) ) 
			{
			 	throw new Error("Service does not exists");
			 	return false;
			}
			var service:Service = _services.obtain(id)[0] as Service;
			return service.createInstance();
		}
		
		/**
		 * Uses <code>getService()</code> method to return an instance of a 
		 * <code>HTTPService</code> Object.  
		 * */
		public function getHTTPService(id:String):HTTPService
		{
			return getService(id) as HTTPService;
		}
		
		/**
		 * Uses <code>getService()</code> method to return an isntance of a 
		 * <code>AMFConnection</code> Object.  
		 * */
		public function getAMFConnection(id:String):AMFConnection
		{
			return getService(id) as AMFConnection;
		}

	}	
	
}
