package wom.controller.event.inbox
{
   import flash.events.Event;
   
   public class InboxEvent extends Event
   {
      
      public static const REQUESTS_UPDATED:String = "requestsUpdated";
      
      public static const REQUESTS_LAYOUT_UPDATED:String = "requestsLayoutUpdated";
      
      public function InboxEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new InboxEvent(type);
      }
   }
}

