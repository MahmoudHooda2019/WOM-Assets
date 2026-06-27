package org.robotlegs.base
{
   import flash.events.IEventDispatcher;
   import org.robotlegs.core.IStarlingEventMap;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class StarlingEventMap extends EventMap implements IStarlingEventMap
   {
      
      protected var starlingListeners:Array;
      
      public function StarlingEventMap(param1:IEventDispatcher)
      {
         super(param1);
         starlingListeners = [];
      }
      
      protected static function routeStarlingEventToListener(param1:Event, param2:Function, param3:Class) : void
      {
         var _loc4_:int = 0;
         if(param1 is param3)
         {
            _loc4_ = param2.length;
            if(_loc4_ == 0)
            {
               param2();
            }
            else if(_loc4_ == 1)
            {
               param2(param1);
            }
            else
            {
               param2(param1,param1.data);
            }
         }
      }
      
      public function mapStarlingListener(param1:EventDispatcher, param2:String, param3:Function, param4:Class = null) : void
      {
         var params:Object;
         var i:int;
         var callback:Function;
         var dispatcher:EventDispatcher = param1;
         var type:String = param2;
         var listener:Function = param3;
         var eventClass:Class = param4;
         if(!eventClass)
         {
            eventClass = Event;
         }
         i = int(starlingListeners.length);
         while(i--)
         {
            params = starlingListeners[i];
            if(params.dispatcher == dispatcher && params.type == type && params.listener == listener && params.eventClass == eventClass)
            {
               return;
            }
         }
         callback = function(param1:Event):void
         {
            var _temp_2:* = param1;
            var _temp_1:* = listener;
            var _loc4_:Class = eventClass;
            var _loc3_:Function = _temp_1;
            var _loc2_:Event = _temp_2;
            if(_loc2_ is _loc4_)
            {
               var _loc5_:int = _loc3_.length;
               if(_loc5_ == 0)
               {
                  _loc3_();
               }
               else if(_loc5_ == 1)
               {
                  _loc3_(_loc2_);
               }
               else
               {
                  _loc3_(_loc2_,_loc2_.data);
               }
            }
         };
         params = {
            "dispatcher":dispatcher,
            "type":type,
            "listener":listener,
            "eventClass":eventClass,
            "callback":callback
         };
         starlingListeners.push(params);
         dispatcher.addEventListener(type,callback);
      }
      
      public function unmapStarlingListener(param1:EventDispatcher, param2:String, param3:Function, param4:Class = null) : void
      {
         var _loc5_:Object = null;
         if(!param4)
         {
            param4 = Event;
         }
         var _loc6_:int = int(starlingListeners.length);
         while(_loc6_--)
         {
            _loc5_ = starlingListeners[_loc6_];
            if(_loc5_.dispatcher == param1 && _loc5_.type == param2 && _loc5_.listener == param3 && _loc5_.eventClass == param4)
            {
               param1.removeEventListener(param2,_loc5_.callback);
               starlingListeners.splice(_loc6_,1);
               return;
            }
         }
      }
      
      override public function unmapListeners() : void
      {
         var _loc1_:Object = null;
         var _loc2_:EventDispatcher = null;
         super.unmapListeners();
         _loc1_ = starlingListeners.pop();
         while(_loc1_)
         {
            _loc2_ = _loc1_.dispatcher;
            _loc2_.removeEventListener(_loc1_.type,_loc1_.callback);
            _loc1_ = starlingListeners.pop();
         }
      }
   }
}

