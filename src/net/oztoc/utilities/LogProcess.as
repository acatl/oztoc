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


package net.oztoc.utilities
{
	/**
	 * Simple Class for saving logs of your process. The <code>log</code> property is
	 * bindable so you can just bind it to a Text component to view its contents. 
	 * */
	public class LogProcess
	{
		[Bindable]
		/**
		 * Static property to which the logs are being saved.
		 * */
		public static var log:String;
		
		/**
		 * Saves the last time the log <code>record()</code> method was called.
		 * */
		private static var lastTime:Number;
		
		/**
		 * Constructor
		 * */
		public function LogProcess()
		{
		}
		
		/**
		 * Adds the value of the passed variable as a string using the <code>toString()</code>
		 * of the object being passed. It saves the string in the following format:
		 * <code>
		 * [milliseconds since last call] + object + \n
		 * </code>
		 * 
		 * @param object any type of object that has the toString() method. 
		 * */
		public static function record(object:Object):void
		{
			var time:Date = new Date();
			
			if ( log == null ) log = "";
			if ( isNaN(lastTime) ) 
			{
				lastTime = time.time;
			}
			
			log+= "[ " + String( time.time - lastTime) + " ] " + object.toString()+"\n";
			
			lastTime = time.time;
		}

	}
}