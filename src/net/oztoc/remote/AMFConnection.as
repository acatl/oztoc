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

package net.oztoc.remote
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.messaging.messages.ErrorMessage;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	[Event(name="netStatus", type="flash.events.NetStatusEvent")]
	
	public class AMFConnection extends EventDispatcher
	{
		
		
		private static var usePersistent:Boolean;
		
		private var conn:Connection;
		private static var pconn:Connection;
		
		public function AMFConnection(usePersistent:Boolean = false):void
		{
			super(null);
			AMFConnection.usePersistent = usePersistent;
		}
		
		private  function get connection():Connection
		{
			var c:Connection;
			if ( AMFConnection.usePersistent )
			{
				if ( !AMFConnection.pconn)
				{
					AMFConnection.pconn =  new Connection();
				}
				c = AMFConnection.pconn;
			}
			else
			{
				if ( !conn )
				{
					conn = new Connection();
				}
				c = conn;
			}
			
			return c;
		}
		
		/** @public */
		public function get remoteClass():String {
			return connection.remoteClass;
		}

		public function set remoteClass(value:String):void {
			connection.remoteClass = value;
		}
		
		/** @public */
		public function get method():String {
			return connection.method;
		}

		public function set method(value:String):void {
			connection.method = value;
		}
		
		/** @public */
		public function get gateway():String {
			return connection.gateway;
		}

		public function set gateway(value:String):void {
			connection.gateway = value;
		}

		 /** @public */
		public function get error():Object {
			return connection.error;
		}
		
		 /** @public */
		public function get response():Object {
			return connection.response;
		}
		
		/** @public */
		public function get decode():Function {
			return connection.decode;
		}

		public function set decode(value:Function):void {
			connection.decode = value;
		}		
		
		
		/**
		* Holds value of the property <code>isProcessing</code>
		**/
		[Bindable]
		public static var isProcessing:Boolean = false;
		
		[Bindable]
		public static var threads:Number = 0;
		
		protected static function updateStatus():void
		{
			trace ( threads );
			isProcessing = threads == 0 ? false : true;
		}
		
		private function onFault (e:Object):void
		{
			connection.error = e;
			var errorMessage:ErrorMessage = e as ErrorMessage;
			var fault:Fault = new Fault(errorMessage.faultCode, errorMessage.faultString, "details: " + errorMessage.faultDetail );
			this.dispatchEvent(new FaultEvent(FaultEvent.FAULT,false,true,fault));
			connection.conn.close();
			AMFConnection.threads--;
			AMFConnection.updateStatus();
		}
		
		private function onNetStatus(e:NetStatusEvent):void
		{
			this.dispatchEvent( e );
		}
		
		private function onResponse(e:Object):void
		{
			var result:Object = e;
			if ( connection.decode != null )
			{
				result = connection.decode ( result );
			}
			connection.response = result;
			this.dispatchEvent(new ResultEvent(ResultEvent.RESULT,false,true,connection.response));
			connection.conn.close();
			AMFConnection.threads--;
			AMFConnection.updateStatus();
		}
		
		
		public function call(method:String, ...rest:Array):void
		{
			connection.conn.connect(this.gateway);
			var resp:Responder = new Responder(onResponse, onFault);
			var remoteCall:String = this.remoteClass + "." + method;
			var callF:Function = connection.conn.call;
			var argArray:Array = new Array (remoteCall, resp);
			argArray = argArray.concat(rest);
			callF.apply( conn, argArray);
			
			AMFConnection.threads++;
			AMFConnection.updateStatus();
		} 
		
		public function send(...rest:Array):void
		{
			if ( connection.method != "" && connection.method != null)
			{
				connection.conn.connect(this.gateway);
				var resp:Responder = new Responder(onResponse, onFault);
				var remoteCall:String = this.remoteClass + "." + connection.method;
				var callF:Function = connection.conn.call;
				var argArray:Array = new Array (remoteCall, resp);
				argArray = argArray.concat(rest);
				callF.apply( conn, argArray);
				AMFConnection.threads++;
				AMFConnection.updateStatus();
			}
		}
		
		

	}
}


import flash.net.NetConnection;
import flash.net.ObjectEncoding;

internal class Connection
{
 	
	public var remoteClass:String;
	public var method:String;
	public var gateway:String;
	public var error:Object;
	public var response:Object;
	public var conn:NetConnection;
	private var _usePersistent:Boolean;
	
	public var decode:Function;
	
	public function Connection():void
	{
		conn = new NetConnection();
		conn.objectEncoding = ObjectEncoding.AMF3;
	}
	
	
}
