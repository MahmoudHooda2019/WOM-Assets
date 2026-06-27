package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class TuskHornSelectMercenaryEvent extends Event
   {
      
      public static const MINUS:String = "minus";
      
      public static const PLUS:String = "plus";
      
      private var _id:int;
      
      public function TuskHornSelectMercenaryEvent(param1:String, param2:int)
      {
         super(param1);
         _id = param2;
      }
      
      override public function clone() : Event
      {
         return new TuskHornSelectMercenaryEvent(type,_id);
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

