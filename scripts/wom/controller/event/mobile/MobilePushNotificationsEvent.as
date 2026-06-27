package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobilePushNotificationsEvent extends Event
   {
      
      public static const SETUP:String = "setupMobilePushNotificationsService";
      
      public function MobilePushNotificationsEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new MobilePushNotificationsEvent(type);
      }
   }
}

