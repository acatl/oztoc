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
	import flash.events.IEventDispatcher;
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.controls.Image;
	import mx.containers.HBox;
	import mx.containers.VBox;

	public class HTMLParser extends CoreParser
	{
		
		public function HTMLParser(target:IEventDispatcher=null)
		{
			super(target);
			addComponent("div", VBox);
			addComponent("div", HBox);
			addComponent("p", Label);
			addComponent("image", Image);
		}
		

		
		
		
		 /** @private Singleton Pattern> */
		private static var _instance:HTMLParser;

		 /** @public <Singleton Pattern> */
		public static function get instance( ):HTMLParser
		{
			if ( !_instance) 
			{
				_instance = new HTMLParser();
			}
			return _instance;
		}
		
	}
}