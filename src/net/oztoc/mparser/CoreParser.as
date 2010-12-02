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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class CoreParser extends EventDispatcher
	{
		
		 /** @private */
		private static var _instance:CoreParser;
		
		private var parser:ComponentParser;
		
		public function CoreParser(target:IEventDispatcher=null)
		{
			super(target);
			parser = new ComponentParser();
		}
		
		
		public function addComponent(name:String, generator:Class):Boolean
		{
			return parser.addComponent(name, generator);
		}
		
		public function parse ( source:XML ):ComponentObject
		{
			var result:ComponentObject = new ComponentObject();
			result.instance = parser.parse(source, result.children);
			return result;
		}
		
		 /** @public */
		public static function get instance():CoreParser {
			if ( !_instance) 
			{
				_instance = new CoreParser();
			}
			return _instance;
		}

	}
}