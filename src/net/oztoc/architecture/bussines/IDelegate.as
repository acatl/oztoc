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
	/**
	 * Interface used when extending the <code>Delegate</code> class. 
	 * 
	 * */
	public interface IDelegate
	{
		/**
		 * This function is used to execute the service call and assign the
		 * <code>responder.result</code> and <code>responder.fault</code>
		 * handlers to listen to their respective events of the service being called.
		 * */
		function execute(param:Object=null):void;		
	}
}