package wom.controller.event.unit
{
   import flash.events.Event;
   
   public class CalculateUnitStatsEvent extends Event
   {
      
      public static const CALCULATE:String = "calculate";
      
      public function CalculateUnitStatsEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new CalculateUnitStatsEvent(type);
      }
   }
}

