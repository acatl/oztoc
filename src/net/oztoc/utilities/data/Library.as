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
	import flash.utils.Dictionary;
	
	/**
	 * This library is for storing objects in a key->value array. You can store any type
	 * of data type such as numbers, string objects, references to other objects or 
	 * Library Objects to create multimensional structures.
	 *  
	 * As an option when creating a new instance of Library Object you can initialize 
	 * its children passing values in the form of: 
	 * <code>
	 * new Library ( { id:"ID", value:"VALUE"},.. );
	 * new Library ( ["ID", "VALUE"],..);
	 * </code>
	 * or use a combination of both such as
	 * <code>
	 * new Library ( { id:"ID0", value:"VALUE"}, ["ID1", "VALUE"],..);
	 * </code>
	 * 
	 * */
	public class Library
	{ 
		 /**
		 * Holds reference to stored bojects in the Library.
		 * */
		private var _children:Array;

		 /**
		 * Returns a reference to all the objects stored in the Library. Each Object is 
		 * in the form of {id,uid, value} where value is the actual object stored. 
		 * Altering this array will affect the Library's collection directly.
		 * */
		public function get children():Array {
			return this._children;
		}
		
		/**
		 * Constructor, please refer to the main description of this class.
		 * */
		public function Library( ...rest:Array)
		{
			_children = new Array();
			
			if ( rest.length >  0 )
			{
				addSet(rest);
			}
		}
		
		/**
		 * Appends the contents passed to the Library's children collection, the 
		 * objects need to be with a specific format described on the main description 
		 * of the class. 
		 * 
		 * @param data Array of bojects to be added to the collection.
		 * */
		public function addSet(data:Array):void
		{
			for each ( var element:Object in data )
			{
				if (element is Array)
				{
					this.add ( element[0] , element[1] );
				}
				else if ( element.hasOwnProperty("id") && element.hasOwnProperty("value") )
				{
					this.add ( element.id , element.value );
				} 
				else
				{
					throw new Error("Can not add element to Library.");
				}
			} 
		}
		
		/**
		 * Checks if the id already exists in the array, if so it will return true.
		 * 
		 * @param id Identifier of the Object being searched.
		 * @return true if element exists.
		 * */
		public function exists(id:String):Boolean
		{
			for each ( var child:ChildElement in _children)
			{
				if ( id ==  child.key ) 
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Adds a new element to the collection. You can add more than one element 
		 * with the same id and obtain all the values related to that Id with the 
		 * <code>obtain()</code> method.
		 * 
		 * @param id identifier of the object being added.
		 * @param value instance or reference to object being added. 
		 * */
		public function add(id:String, value:Object):Boolean
		{
			
			var child:ChildElement = new ChildElement(id, value);
			_children.push( child );
			return true;
		}
		
		/**
		 * Removes one or more elements found with the same id passed to the 
		 * method.
		 * 
		 * @param id Identifier of the object that you want to be removed.
		 * */
		public function remove(id:String):void
		{
			for ( var i:uint = 0; i<= _children.length-1; i++)
			{
				if ( id ==  _children[i].key ) 
				{
					_children.splice(i,1);
				}
			}			
		}
		
		/**
		 * Returns an array with <b>only</b> the values stored in the collection 
		 * that are related to the specified id passed to the method.
		 * 
		 * @param id Identifier of the object or set of objects that will be returned 
		 * if found.
		 * */
		public function obtain(id:String):Array
		{
			var result:Array = new Array();	
			for each ( var child:ChildElement in _children)
			{
				if ( id ==  child.key ) 
				{
					result.push( child.value );
				}
			}
			return result;
		}
	}
}

	import mx.utils.UIDUtil;
	
	
	class ChildElement
	{
		public var uid:String;
		public var key:String;
		public var value:Object;
		
		public function ChildElement( key:String, value:Object, uid:String=null):void
		{
			if ( uid==null)
			{
				this.uid = UIDUtil.createUID();
			}
			this.key = key;
			this.value = value;
		}
		
	}
