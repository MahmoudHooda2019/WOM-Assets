package wom.controller.event
{
   import flash.events.Event;
   
   public class KeepAliveEvent extends Event
   {
      
      public static const KEEP_ALIVE:String = "keepAlive";
      
      public function KeepAliveEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new KeepAliveEvent(type);
      }
   }
}

