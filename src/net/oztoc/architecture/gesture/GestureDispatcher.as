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

    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import net.oztoc.utilities.data.Library;

    /**
     * This Class is used indectly by the <code>GestureController</code>
     * and also is used directly for executing <code>GestureEvent<code>s.
     *
     * The purpose of this class is to store all the <code>GestureCommand</code>
     * that will be used by the application.
     *
     * @see net.oztoc.utilities.data.Library
     * @seenet.oztoc.architecture.bussines.Delegate
     * @seenet.oztoc.architecture.bussines.GestureCommand
     * @seenet.oztoc.architecture.bussines.GestureEvent
     * @seenet.oztoc.architecture.bussines.GestureController
     *
     * */
    public class GestureDispatcher
    {
        /**
         * Stores all the Class Objects that are registered through the
         * <code>GestureController</code> Class
         *
         * Each Item is stired in name pair values, meaning: Id,Class. Where ID is the
         * GestureEvent name associated with the Class. and Class is the
         * <code>GestureCommand</code> Class Object.
         * */
        private static var gestures:Library;

        /**
         * Constructor
         * */
        public function GestureDispatcher()
        {
            GestureDispatcher.gestures=new Library();
        }

        /**
         * Adds a <code>GestureCommand</code> Class Object and its
         * corresponding id.
         *
         * @param id name of the <code>GestureEvent</code>
         * @param gesture  name of the <code>GestureCommand</code>
         * Class Object
         *
         * @return <code>false</code> if a <code>GestureCommand</code>
         * Class Object has already been registered with the same id.
         * <code>true</code> if was added succesfully.
         * */
        public function addGesture(id:String, gesture:Class):Boolean
        {
            if (GestureDispatcher.gestures.exists(id))
            {
                return false;
            }
            GestureDispatcher.gestures.add(id, gesture);
            return true;
        }

        /**
         * Removes a <code>GestureCommand</code> Class Object that is
         * associated with the passed <code>id</code> value from the
         * <code>gestures</code> property.
         *
         * @param id name of the <code>GestureEvent</code>
         * */
        public function removeGesture(id:String):Boolean
        {
            if (!GestureDispatcher.gestures.exists(id))
            {
                return false;
            }
            GestureDispatcher.gestures.remove(id);
            return true;
        }

        /**
         * This method executes a <code>GestureCommand</code> associated to
         * the <code>GestureEvent<code> being passed.
         * If the <code>GestureEvent<code> has not been resgistered before it wll
         * throw an error.
         * */
        public static function execute(gestureEvent:GestureEvent, completeHandler:Function=null, failHandler:Function=null):Boolean
        {
            if (!gestures.exists(gestureEvent.type))
            {
                throw new Error("Gesture does not exists");
                return false;
            }
            var gestureClass:Class=gestures.obtain(gestureEvent.type)[0] as Class;
            var instance:GestureCommand=new gestureClass(gestureEvent);

            var responder:IResponder=gestureEvent.callBacks;

            if (responder != null)
            {
                if (responder.result != null)
                {
                    instance.addEventListener(ResultEvent.RESULT, responder.result);
                }

                if (responder.fault != null)
                {
                    instance.addEventListener(FaultEvent.FAULT, responder.fault);
                }
            }

            //TODO: should be deprecated soon...

            if (completeHandler != null)
            {
                instance.addEventListener(ResultEvent.RESULT, completeHandler);
            }

            if (failHandler != null)
            {
                instance.addEventListener(FaultEvent.FAULT, failHandler);
            }
            instance.execute();
            return true;
        }
    }
}