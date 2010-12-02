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

package net.oztoc.mparser
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	
	import net.oztoc.utilities.data.Library;
	
	internal class ComponentParser extends EventDispatcher
	{
		
		 /**  Method Description */
		public function ComponentParser(target:IEventDispatcher=null):void
		{
			super(target);
			_library = new Library();
		}

		/** @private */
		protected var _library:Library;
		
		 /** @public */
		public function get library():Library {
			return this._library;
		}

		public function set library(value:Library):void {
			this._library = value;
		}
		
		 /** @private */
		protected var _dataProvider:XML;

		 /** @public */
		public function get dataProvider():XML {
			return this._dataProvider;
		}

		public function set dataProvider(value:XML):void {
			this._dataProvider = value;
		}
		
		 /**  Method Description */
		public function addComponent(name:String, generator:Class):Boolean
		{
			return library.add(name, generator);
		}
		
		 /**  Method Description */
		public function parse(component:XML = null, subscribers:Object = null):UIComponent
		{
			trace(component.localName());
			
			if ( component == null) this.dataProvider;
			
			var constructor:Class = library.obtain(component.localName())[0] as Class;
			var instance:UIComponent;
			if ( !constructor ) 
			{
				return null;
			}
			
			instance = new constructor();
			
			for each ( var att:XML  in component.attributes() )
			{
				trace ( att.name().toString()  + "=" + att );
				if ( instance.hasOwnProperty( att.name() )  )
				{
					
					instance[att.name().toString()] = att;
				}
				
				if ( att.name().toString() == "id")
				{
					if ( subscribers )
					{
						if ( subscribers[att.name().toString()] == null ) 
						{
							subscribers[att] = instance;
						}
					}
				}
				
				else 
				{
					
					trace (  att.name().toString() + " = " +  att);
					instance.setStyle( att.name().toString() , att);
				}
			}
			
			if ( instance is Container)
			{
				trace ( "is container");
				var child:DisplayObject;
				for each( var subComponent:XML in component.children())
				{
					child = parse(subComponent,subscribers);
					if ( child )	
					instance.addChild ( child );
				}
			}
			
			return instance;
		}

		
		
		
	}
}