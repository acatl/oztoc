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


package net.oztoc.architecture.gesture
{
	import mx.rpc.IResponder;
	

	/**
	 * This class is used to work with the <code>GestureController</code>, 
	 * <code>GestureDispatcher</code>, <code>GestureCommand</code> and 
	 * <code>GestureController</code>. 
	 * 
	 * You will use this class to create your own custom GestureEvents, each 
	 * <code>GestureEvent</code> is associated to a 
	 * <code>GestureCommand</code>. In order to execute a 
	 * <code>GestureCommand</code> you will need to register your custom
	 * <code>GestureEvent</code>s and <code>GestureCommand</code>s on the 
	 * <code>GestureController</code>. Once they are registered. they are ready to 
	 * be executed by the <code>GestureDispatcher</code>.
	 * 
	 * @see  net.oztoc.architecture.gesture.GestureCommand
	 * @see  net.oztoc.architecture.gesture.GestureController
	 * @see  net.oztoc.architecture.gesture.GestureDispatcher
	 * @see  net.oztoc.architecture.bussines.Delegate
	 * */
	public dynamic class GestureEvent
	{
		/**
		 * Static constant used to identify a succesful <code>GestureEvent</code>.
		 * */
		public static const SUCCESS:String = "SUCCESS";
		
		/**
		 * Static constant used to identify a fault <code>GestureEvent</code>.
		 * */
		public static const FAIL:String= "FAIL";
		
		/**
		 * In order for an <code>GestureEvent</code> to work be sure to set this 
		 * on the cosntructor of your extended class. Otherwise the 
		 * <code>GesutureDispatcher</code> will not be able to find the 
		 * <code>GestureCommand</code> and it will fail silently.
		 * 
		 * @see  net.oztoc.architecture.gesture.GestureDispatcher
		 * */
		public var type:String;
		
		/**
		 * Reference to the Object that's executing the event.
		 * */
		public var callBacks:IResponder;
		
		/**
		 * Reference to a data object passed to the event.
		 * */
		public var data:*;
		
		/**
		 * Constructor
		 * 
		 * @param target Reference to the Object that's executing the event.
		 * */
		public function GestureEvent(type:String, data:* = null, callBacks:IResponder=null)
		{
			this.type = type;
			this.data = data;
			this.callBacks = callBacks;
		}
	}
}