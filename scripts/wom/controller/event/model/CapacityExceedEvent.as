package wom.controller.event.model
{
   import flash.events.Event;
   
   public class CapacityExceedEvent extends Event
   {
      
      public static const CAPACITY_EXCEED_IN_BLACKSMITH:String = "capacityexceedinblacksmith";
      
      private var _index:int;
      
      public function CapacityExceedEvent(param1:String, param2:int)
      {
         super(param1);
         _index = param2;
      }
      
      override public function clone() : Event
      {
         return new CapacityExceedEvent(type,_index);
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}

