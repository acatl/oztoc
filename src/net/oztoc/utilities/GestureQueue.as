/*

Copyright(c) 2010 Acatl Pacheco
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
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    import net.oztoc.architecture.gesture.GestureDispatcher;
    import net.oztoc.architecture.gesture.GestureEvent;
    
    
    /**
    * You can use this class to add GestureEvents so they can be executed
    * one by one, the order of execution is FIFO (First in First Out). 
    * 
    * Once completed an Event.COMPLETE event will be dispatched. In case
    * one GestureEvent fails to execute, the FaultEvent Object recieved
    * from the failing GestureEvent will be dispatched. 
    * */
    public class GestureQueue extends EventDispatcher
    {
        /**
        * Stack of GestureEvents 
        * */
        protected var queue:Array;
        
        /**
        * True if the Queue is running, once the queue finishes it will
        * go back to False.
        * */
        protected var isRunning:Boolean;
        
        
        /**
        * Constructor
        * */
        public function GestureQueue(target:IEventDispatcher=null)
        {
            super(target);
            queue = [];
            isRunning = false;
        }
        
        /**
        * adds an GestureEvent Object instance to the Queue
        * */
        public function addGesture(event:GestureEvent):void
        {
            queue.push(event);
        }
        
        /**
        * Executes the queue
        * */
        public function execute():Boolean
        {
            if(!isRunning)
            {
                queue = queue.reverse();
            }
            
            isRunning = true;
            
            if(queue.length==0)
            {
                isRunning = false;
                dispatchEvent( new Event(Event.COMPLETE));
                return false;
            }
            
            GestureDispatcher.execute(queue.pop() as GestureEvent, complete_handler, fail_handler);
            
            return true;
        }
        
        private function complete_handler(event:ResultEvent):void
        {
            execute();
        }
        
        private function fail_handler(event:FaultEvent):void
        {
            dispatchEvent( event );
        }
            
    }
}