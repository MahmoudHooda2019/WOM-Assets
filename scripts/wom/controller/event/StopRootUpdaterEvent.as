package wom.controller.event
{
   import flash.events.Event;
   
   public class StopRootUpdaterEvent extends Event
   {
      
      public static const STOP:String = "stopRoot";
      
      public function StopRootUpdaterEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new StopRootUpdaterEvent(type);
      }
   }
}

