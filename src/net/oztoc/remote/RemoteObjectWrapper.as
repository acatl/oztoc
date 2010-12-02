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

package net.oztoc.remote
{
	import flash.xml.XMLDocument;
	
	import net.oztoc.utilities.data.AbstractConsumer;
	
	dynamic public class RemoteObjectWrapper
	extends AbstractConsumer
	{
		public var uid:String;
		public var error:ErrorInfo;
		
		 /** @private */
		private var _result:Object;
		
		/** @private */
		private var _resultType:Class;

		public function RemoteObjectWrapper(resultType:Class=null, source:XML=null):void
		{
			super(null);
			
			this.addObject("error", ErrorInfo);
			//this.addObject("result", XML);
						 
			this.resultType = resultType;
			
			if ( source != null)
			{
				this.dataProvider = source;
			}
		}
		
		/** @public */
		public function get result():Object
		{
			return this._result;
		}

		public function set result(value:Object):void
		{
			var data:*;
			if ( resultType!= null)
			{			
				data = new resultType ( ) ;
				(data as AbstractConsumer).dataProvider = XML(value).children()[0] ;
			}
			else
			{
				data = XML(value).children()[0];
			}
			this._result = data;
		}
		
		/** @public */
		public function get resultType():Class
		{
			return this._resultType;
		}

		public function set resultType(value:Class):void
		{
			this._resultType = value;
		}
		
		public function decode(dataProvider:*):*
		{ 
			if ( dataProvider is XMLDocument ) this.dataProvider = new XML ( (dataProvider as XMLDocument).toString() );
			return this;
		}
	}
}