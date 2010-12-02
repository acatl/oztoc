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
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.Text;

	public class MXMLParser extends CoreParser
	{
		
		public function MXMLParser(target:IEventDispatcher=null)
		{
			super(target);
			addComponent("Canvas", Canvas);
			addComponent("HBox", HBox);
			addComponent("VBox", VBox);
			addComponent("Label", Label);
			addComponent("Text", Text);
			addComponent("Image", Image);
		}
		
		
		 /** @private Singleton Pattern> */
		private static var _instance:MXMLParser;

		 /** @public <Singleton Pattern> */
		public static function get instance( ):MXMLParser
		{
			if ( !_instance) 
			{
				_instance = new MXMLParser();
			}
			return _instance;
		}
		
	}
}