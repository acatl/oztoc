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

 
package net.oztoc.architecture.bussines
{
	import mx.rpc.IResponder;
	
	/**
	 * Base class for extending a custom Delegate, a delegate is a class that is
	 * responsible of using a Service to retrive data from a server and parsing
	 * the response if needed and passing it to the <code>responder</code>
	 * object. 
	 * 
	 * The responder object is an object that is recommended to to extend the
	 * <code>GestureCommand</code> Class.
	 * 
	 * To extend the <code>Delegate</code> class I recomend implementing the
	 * interface <code>IDelegate</code>.
	 * 
	 * @see  net.oztoc.architecture.bussines.IDelegate
	 * @see  net.oztoc.architecture.gesture.GestureCommand
	 * @see  net.oztoc.architecture.gesture.IGestureCommand
	 * */
	public dynamic class Delegate
	{
		/**
		 * Holds a reference to the responder object assigned through the
		 * constructor of this class.
		 * */
		public var responder:Object;
		
		/**
		 * Constructor
		 * @param responder GestureCommand
		 * */
		public function Delegate(responder:IResponder)
		{
			this.responder  =  responder;
		}
		
	}
}