package wom.controller.event.model
{
   import flash.events.Event;
   
   public class GoToWindowEvent extends Event
   {
      
      public static const GO_TO_STORE:String = "gotostore";
      
      public function GoToWindowEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GoToWindowEvent(type);
      }
   }
}

