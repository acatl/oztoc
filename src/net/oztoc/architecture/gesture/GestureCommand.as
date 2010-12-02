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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	
	/**
	 * The purpose of a <code>GestureCommand</code> is to execute a 
	 * <code>Delegate</code> and be passed itself as a reference to be the 
	 * <b>responder</b> object for the Delegate class being executed. 
	 * 
	 * This Class is responsible of modifing the Model, and uses the a 
	 * <code>Delegate</code> class to make the call. It is not supposed to parse 
	 * any information. Any bussines logic that modifies the Model should be applied
	 * here.
	 * 
	 * @see net.oztoc.utilities.event.GestureEvent
	 * @see net.oztoc.utilities.bussines.Delegate
	 * 
	 * */
	public dynamic class GestureCommand extends EventDispatcher implements IResponder
	{
		/**
		 * holds the associated <code>GestureEvent</code> with the 
		 * <code>GestureCommand</code>.
		 * */
		public var event:GestureEvent;
		
		/**
		 * Constructor
		 * 
		 * @param GestureEvent event associated with the class.
		 * */
		public function GestureCommand (event:GestureEvent)
		{
			super(null);
			this.event = event;
		}
		
		/**
		 * Important: Avoid overriding this class. 
		 * 
		 * This function is used by the <code>Delegate</code> it is called when the
		 * call to the server was executed succesfully. Usually a 
		 * <code>ResultEvent</code> will be recived as the first parameter.
		 * 
		 * It will call the <code>succes()</code> function that is the one to be 
		 * overriden when extending this class, afterwards it will dispatch a
		 * <code>GestureEvent.SUCCES</code> Event to notify that the Gesture 
		 * was completed succesfully.
		 * 
		 * @param event Event Object passed from the Delegate class when used 
		 * as a responder object.     
		 * */
		public function result(event:Object):void
		{
			success(event as ResultEvent);
			dispatchEvent( event as Event);
		}
		
		
		/**
		 * Important: Avoid overriding this class. 
		 *
		 * This funciton works similar to the <code>result()</code> function with 
		 * the difference that it will be executed when the call to the server had
		 * returned an error. Just as <code>result()</code> it will dispatch a 
		 * <code>GestureEvent.FAIL</code> at the end of its execution.
		 * 
		 * @param event Event Object passed from the Delegate class when used 
		 * as a responder object.   
		 * */
		public function fault(event:Object):void
		{
			fail(event as FaultEvent);
			dispatchEvent( event as Event);
		}
		
		/**
		 * Place any code that will handle a <b>succesfull</b> call to the server 
		 * by overriding this method.
		 * 
		 * @param event Event Object passed by the <code>result</code> method. 
		 * */
		protected function success(event:ResultEvent):void	{		}
		
		/**
		 * Place any code that will handle a <b>fault</b> call to the server 
		 * by overriding this method.
		 * 
		 * @param event Event Object passed by the <code>fault</code> method. 
		 * */ 
		protected function fail(e:FaultEvent):void	{		} 
		
	}
}