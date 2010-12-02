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
	/**
	 * Interface to be implemented when extending the 
	 * <code>GestureCommand</code> Class. IT forces to use an 
	 * <code>execute()</code> function that is also used by the 
	 * <code>GestureMacro</code> and the <code>GestureDispatcher</code> 
	 * Class.
	 * 
	 * @see net.oztoc.architecture.gesture.GestureDispatcher
	 * @see net.oztoc.architecture.gesture.GestureController
	 * @see net.oztoc.architecture.gesture.GestureCommand
	 * @see net.oztoc.architecture.gesture.GestureEvent
	 * 
	 * */
	public interface IGestureCommand
	{
		/**
		 * Funciton that will execute the custom Delegate class.
		 * */
		function execute():void;
		
	}
}