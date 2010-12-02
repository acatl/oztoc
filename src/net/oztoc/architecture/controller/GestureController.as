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


package net.oztoc.architecture.controller
{
	import net.oztoc.architecture.gesture.GestureDispatcher;

	/**
	 * This class is meant to be extended, it references the
	 * <code>GestureDispatcher</code> on its <code>addGesture()</code> and
	 * <code>removeGesture()<code> functions, it serves as an interface to register 
	 * <code>GestureCommands</code> to the <code>GestureDispatcher</code>. 
	 * 
	 * On the class that extends this class you will add your commands that you need 
	 * your application to execute.
	 * 
	 * @see net.oztoc.architecture.gesture.GestureDispatcher
	 * @see net.oztoc.architecture.gesture.GestureEvent
	 * @see net.oztoc.architecture.gesture.GestureCommand
	 * @see net.oztoc.architecture.gesture.IGestureCommand
	 * */
	public class GestureController
	{
		/**
		 * holds an istance of a <code>GestureDispatcher</code> Class 
		 * that will be responsible to trigger the Gestures when a 
		 * <code>GestureEvent</code> is executed.  
		 * */
		private var gestureDispatcher:GestureDispatcher;
		
		/**
		 * Constructor
		 * */
		public function GestureController()
		{
			gestureDispatcher = new GestureDispatcher();
		}
		
		/**
		 * Adds a custom Gesture's Class signature to the GestureDispatcher.
		 * 
		 * @param id name of the GestureEvent that will be assoiciated with the 
		 * Gesture
		 * 
		 * @param gesture Gesture's Class Signature that will be registered
		 * @return <code>true</code> if gesture was added succesfully.
		 * */
		public function addGesture(id:String, gesture:Class):Boolean
		{
			return gestureDispatcher.addGesture(id, gesture);
		}
		
		/**
		 * Removes any Gestures from the GestureDispatcher that are associated to 
		 * the passed <code>id</code>.
		 * 
		 *   @param id Name of the Gesture that will be removed from the 
		 * GestureDispatcher.
		 * @return <code>true</code> if gesture was removed succesfully.
		 * */
		public function removeGesture(id:String):Boolean
		{
			return gestureDispatcher.removeGesture(id);
		}
	
	}
}