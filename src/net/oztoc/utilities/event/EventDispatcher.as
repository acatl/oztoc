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

package net.oztoc.utilities.event
{
	import net.oztoc.utilities.data.Library;
	
	public class EventDispatcher
	{
		private var _collection:Library;
		
		public function EventDispatcher()
		{
			_collection = new Library();
		}
		
		public function addEventListener(id:String, gesture:Function):Boolean
		{
			_collection.add(id, gesture);
			return true;
		}
		
		public function dispatchEvent(id:String):void
		{
			var listeners:Array = _collection.obtain(id);
			var listener:Function;
			var event:Object = new Object();
			event.target = this;
			event.type = id;
			for ( var i:int = 0; i<= listeners.length-1; i++)
			{
				listener = listeners[i];
				listener(event);
			}
		}
			
		public function removeEventListener(id:String):Boolean
		{
			if ( !_collection.exists(id) )
			{
				return false;
			}
			_collection.remove(id);
			return true;
		}

	}
}