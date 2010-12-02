package net.oztoc.utilities
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	[Event(name="complete", type="flash.events.Event")]

	dynamic public class Configuration extends EventDispatcher
	{
		public static var data:*; 
		private static var _preferences:SharedObject; 
		
		public function Configuration(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load():void
		{
			var loader:URLLoader = new URLLoader();
            configureListeners(loader);
            var request:URLRequest = new URLRequest("config.xml");
            try {
                loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
		}
		
		
		public static function get preferences():SharedObject
		{
			if ( _preferences == null)
			{
				_preferences = SharedObject.getLocal(Configuration.data.id);
			}
			return _preferences;
		}
		
		private function parse(target:*, data:*):void
		{
			var dataProvider:XML = new XML ( data );
			for each( var node:XML in dataProvider.children())
			{
				var value:* = node;
			
				if ( node.children()[0].children().length() == 0 )
				{
					
					if ( !isNaN( Number( value ) )  )
					{
						value = Number( value )
					}
					else if ( value == "true" || value =="false" )
					{
						value = ( value == "true" ) ? true : false;
					}
					else 
					{
						value = node.text().toString();
					}
				}
				target[node.localName()] = value;
			}
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            //trace("config Loaded");
            Configuration.data = new Object();
            parse(Configuration.data, loader.data );
            dispatchEvent( new Event( Event.COMPLETE ) );
        }

        private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            //trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
            dispatchEvent( event );
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            //trace("securityErrorHandler: " + event);
            dispatchEvent( event );
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            //trace("ioErrorHandler: " + event);
            dispatchEvent( event );
        }

	}
}