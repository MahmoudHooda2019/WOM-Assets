package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.viral.UserNotification;
   
   public class UserNotificationEvent extends Event
   {
      
      public static const SHOW:String = "userNotificationEventShow";
      
      public static const COMPLETED:String = "userNotificationEventCompleted";
      
      private var _notification:UserNotification;
      
      public function UserNotificationEvent(param1:String, param2:UserNotification = null)
      {
         super(param1);
         _notification = param2;
      }
      
      override public function clone() : Event
      {
         return new UserNotificationEvent(type,_notification);
      }
      
      public function get notification() : UserNotification
      {
         return _notification;
      }
   }
}

