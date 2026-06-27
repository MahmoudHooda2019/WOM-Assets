package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class ExecutionalGuillotineSelectMercenaryEvent extends Event
   {
      
      public static const SELECT_MERCENARY:String = "executionalGuillotineSelectMercenaryEvent";
      
      public function ExecutionalGuillotineSelectMercenaryEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new ExecutionalGuillotineSelectMercenaryEvent(type);
      }
   }
}

