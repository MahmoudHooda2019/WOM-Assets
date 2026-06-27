package wom.controller.event.visit
{
   import flash.events.Event;
   
   public class EndVisitEvent extends Event
   {
      
      public static const END_VISIT:String = "endVisit";
      
      public function EndVisitEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new EndVisitEvent(type);
      }
   }
}

