package wom.controller.event.ui
{
   import starling.events.Event;
   
   public class MobileUserNotificationViewEvent extends Event
   {
      
      public static const COMPLETED:String = "mobileUserNotificationViewEventCompleted";
      
      public function MobileUserNotificationViewEvent(param1:String)
      {
         super(param1);
      }
   }
}

