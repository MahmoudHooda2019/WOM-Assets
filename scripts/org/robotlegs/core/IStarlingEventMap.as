package org.robotlegs.core
{
   import starling.events.EventDispatcher;
   
   public interface IStarlingEventMap extends IEventMap
   {
      
      function mapStarlingListener(param1:EventDispatcher, param2:String, param3:Function, param4:Class = null) : void;
      
      function unmapStarlingListener(param1:EventDispatcher, param2:String, param3:Function, param4:Class = null) : void;
   }
}

