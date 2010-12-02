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

package net.oztoc.utilities.data
{
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	
	public class AbstractConsumer extends Object
	{
		 /** @private */
		private var _dataProvider:XML;
		
		protected var _classFactoryCollection:Array;
		
		public function AbstractConsumer(source:XML =null)
		{
			if ( source )
			{ 
				this._dataProvider = source;
			}
			_classFactoryCollection = new Array();
		}
		
		 /** @public */
		[Bindable]
		public function get dataProvider():* {
			return this._dataProvider as XML;
		}

		public function set dataProvider(value:*):void {
			if ( value is XMLDocument ) value = new XML ( (value as XMLDocument).toString() );
			this._dataProvider = value;
			parse(this._dataProvider);
		}

		public function addObject ( name:String, constructor:Class ):void
		{
			addClassFacotry( name, constructor, true);
		}
		
		public function addCollection ( name:String, constructor:Class ):void
		{
			addClassFacotry( name, constructor, false);
		}
		
		 /**  Method Description */
		protected function addClassFacotry( name:String, constructor:Class , unique:Boolean = true) :void
		{
			if ( _classFactoryCollection == null) _classFactoryCollection = new Array();	 
			_classFactoryCollection.push ( new ClassFactory (  name, constructor, unique ) ); 
		}
		
		 /**  Method Description */
		protected function getClassFactory(name:String ):ClassFactory
		{
			if ( _classFactoryCollection == null) 
			{ 
				_classFactoryCollection = new Array();
				return null;
			}
			
			for ( var i:Number = 0; i<= _classFactoryCollection.length-1; i++)
			{
				if ( _classFactoryCollection[i].name == name)
				{
					return _classFactoryCollection[i];
				}
			}
			return null;
		}
		
		
		protected function parse(dataProvider:*):void
		{
			var cf:ClassFactory;
			if ( dataProvider is XMLDocument ) dataProvider = new XML ( (dataProvider as XMLDocument).toString() );
			for each( var node:XML in dataProvider)
			{
				if ( this.hasOwnProperty( node.localName() )  )
				{
					cf = getClassFactory( node.localName() );
					
					if ( cf != null )
					{
						if (cf.unique)
						{ 
							this[node.localName()] = parseObject  ( node, cf.constructor );
						}
						else
						{
							var dataSet:Array = parseCollection  ( node, cf.constructor );
							this[node.localName()] = new ArrayCollection ( dataSet );
						}					
					} 
					else 
					{				
						this[node.localName()] = node;
					}
				}
			}
			
			for each ( var att:XML  in dataProvider.attributes() )
			{
				if ( this.hasOwnProperty( att.name() )  )
				{
					this[att.name().toString()] = att;
				}
			}
		}
		
		public function parseObject( source:XML, constructor:Class = null):Object
		{
			var cf:ClassFactory;
			var consumer:Object;
			if ( constructor == null ) 
			{
				cf = getClassFactory( source.localName() );
				if ( cf == null ) 
				{
					return null;
				}
				constructor = cf.constructor;
			}
			
			consumer = new constructor ( ) ;
			(consumer as AbstractConsumer).dataProvider = source;
			
			return consumer;
		}
		
		public function parseCollection( source:XML, constructor:Class = null):Array
		{
			var result:Array = new Array();
			var cf:ClassFactory;
	
			if ( constructor == null ) 
			{
				cf = getClassFactory( source.localName() );
				if ( cf == null ) 
				{
					return result;
				}
				constructor = cf.constructor;
			}
			
			var child:*;	
			for each( var node:XML in source.children())
			{
				child = new constructor ()
				child.dataProvider = node;
				result.push(  child ); 
			}
			return result;
		}

	}
}

class ClassFactory
{
	public var name:String;
	public var constructor:Class;
	public var unique:Boolean;
	
	public function ClassFactory(name:String, constructor:Class, unique:Boolean = true):void
	{
		this.name = name;
		this.constructor = constructor;
		this.unique = unique;
	}
}