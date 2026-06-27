package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.game.UserInfo;
   
   public class UserNotificationCommand extends PCommand
   {
      
      [Inject]
      public var event:UserNotificationEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function UserNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(event.notification != null)
         {
            userInfo.notifications.push(event.notification);
            dispatch(new UserNotificationEvent("userNotificationEventCompleted"));
         }
      }
   }
}

