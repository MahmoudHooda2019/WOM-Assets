package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.ServerSpeedChangedEventNotification;
   
   public class HandleServerSpeedChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleServerSpeedChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ServerSpeedChangedEventNotification = messageReceivedEvent.message as ServerSpeedChangedEventNotification;
         userInfo.serverSpeed = _loc1_.serverSpeed;
      }
   }
}

