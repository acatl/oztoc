package net.oztoc.utilities
{
 import flash.events.Event;
 import flash.events.HTTPStatusEvent;
 import flash.events.IOErrorEvent;
 import flash.events.ProgressEvent;
 import flash.events.SecurityErrorEvent;
 import flash.net.URLLoader;
 import flash.net.URLRequest;
 import flash.utils.Dictionary;

 import mx.utils.StringUtil;

 public class PropertiesLoader extends URLLoader
 {
  /**
   * Holds value of the property <code>url</code>
   **/
  private var _url:String = "properties";

  
  [Bindable("urlChange")]
  /**
   * Documentation goes here..
   **/
  public function get url():String
  {
   return _url;
  }

  public function set url(value:String):void
  {
   _url = value;
   dispatchEvent(new Event("urlChange"));
  }

  
  public function PropertiesLoader()
  {
      super(null);
      addEventListener(Event.COMPLETE, completeHandler);
      addEventListener(Event.OPEN, openHandler);
      addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
      addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
      addEventListener(ProgressEvent.PROGRESS, progressHandler);
      addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
  }

  public function propertiesload():void
  {
      var request:URLRequest = new URLRequest(url);
      try {
          super.load(request);
      } catch (error:Error) {
          trace("Unable to load requested document.");
      }
  }

  protected function completeHandler(event:Event):void {
      //trace("config Loaded");
      data = decode(this.data);
      dispatchEvent( new Event( Event.CHANGE ) );
  }

  protected function openHandler(event:Event):void {
      //trace("openHandler: " + event);
  }

  protected function progressHandler(event:ProgressEvent):void {
      //trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
  }

  protected function securityErrorHandler(event:SecurityErrorEvent):void {
      //trace("securityErrorHandler: " + event);
  }

  protected function httpStatusHandler(event:HTTPStatusEvent):void {
      //trace("httpStatusHandler: " + event);
  }

  protected function ioErrorHandler(event:IOErrorEvent):void {
      //trace("ioErrorHandler: " + event);
  }

  protected function decode(data:String):Dictionary
  {
      data = data.replace(/\t/g,"");
      var lines:Array = data.split( "\n" );
      var properties:Dictionary = new Dictionary();
      for each ( var line:String in lines )
      {
          if (line == "") continue;
          var pair:Array = line.split( "=", 2 );
          if (pair != null && pair.length == 2)
              properties[StringUtil.trim(pair[0])] = StringUtil.trim(pair[1]);
      }
      return properties;
  }
 }
}
