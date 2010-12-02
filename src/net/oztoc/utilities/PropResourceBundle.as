package net.oztoc.utilities
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mx.events.ResourceEvent;
    import mx.resources.IResourceBundle;
    import mx.resources.ResourceBundle;
    import mx.resources.ResourceManagerImpl;

    public class PropResourceBundle extends ResourceBundle
    {
        private var pl:PropertiesLoader;

        public function PropResourceBundle(locale:String = null, bundleName:String = null)
        {
            super(locale, bundleName);
        }

        public function loadResourceProperties(url:String):IEventDispatcher
        {
            pl = new PropertiesLoader();
            pl.url = url;

            pl.propertiesload();

            pl.addEventListener(Event.CHANGE, completeHandler);
            var resourcepropEventDispatcher:ResourcePropEventDispatcher =
                new ResourcePropEventDispatcher(pl);

            return resourcepropEventDispatcher;
        }

        protected function completeHandler(event:Event):void {
            for (var key:String in pl.data)
            {
                this.content[key] = pl.data[key];
            }
        }

    }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;

import net.oztoc.utilities.PropertiesLoader;

import mx.events.ResourceEvent;

    class ResourcePropEventDispatcher extends EventDispatcher
    {
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         *  Constructor.
         */
        public function ResourcePropEventDispatcher(pl:PropertiesLoader)
        {
            super();

            pl.addEventListener(IOErrorEvent.IO_ERROR, propLoader_errorHandler);
            pl.addEventListener(SecurityErrorEvent.SECURITY_ERROR, propLoader_errorHandler);

            pl.addEventListener(ProgressEvent.PROGRESS, propLoader_progressHandler);
        
            pl.addEventListener(Event.CHANGE, propLoader_readyHandler);
        }

        //--------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //--------------------------------------------------------------------------

        /**
         *  @private
         */
        private function propLoader_errorHandler(event:Event):void
        {
            var resourceEvent:ResourceEvent = new ResourceEvent(
                                                                ResourceEvent.ERROR, event.bubbles, event.cancelable);
            resourceEvent.bytesLoaded = 0;
            resourceEvent.bytesTotal = 0;
            resourceEvent.errorText = event.toString();
            dispatchEvent(resourceEvent);
        }

        /**
         *  @private
         */
        private function propLoader_progressHandler(event:ProgressEvent):void
        {
            var resourceEvent:ResourceEvent = new ResourceEvent(ResourceEvent.PROGRESS, event.bubbles, event.cancelable);
            resourceEvent.bytesLoaded = event.bytesLoaded;
            resourceEvent.bytesTotal = event.bytesTotal;
            dispatchEvent(resourceEvent);
        }

        /**
         *  @private
         */
        private function propLoader_readyHandler(event:Event):void
        {
            var resourceEvent:ResourceEvent =
                new ResourceEvent(ResourceEvent.COMPLETE);
            dispatchEvent(resourceEvent);
        }
    }

