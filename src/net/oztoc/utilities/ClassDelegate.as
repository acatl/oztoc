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
	public class ClassDelegate
	{
		// Class object to be instantiated
		public var classObject:Class;
		//method to be called
		public var delegate:String;
		// constructor
		public function ClassDelegate( classObject:Class, delegate:String="execute")
		{
			this.classObject = classObject;
			this.delegate = delegate;
		}
		// create the delegate function
		public function execute(...rest:Array):void
		{
			// we create the new instance
			var instance:Object = new classObject();
			// we pass the parameters to the assigned method  or property
			if ( instance[delegate] is Function) 
			{
				instance[this.delegate].apply(instance, rest);
			}
			else
			{
				instance[this.delegate] = rest[0];
			}
		}
		public static function create (classObject:Class, method:String="execute"):Function
		{
			// we create the new instance and pass the Class object and the default method to be executed
			var delegate:ClassDelegate= new ClassDelegate(classObject, method);
			// notice: we pass the function as an 'Function' Object
			return delegate.execute;
		}
	}
}