package wom.controller.command.chat
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.UserBannedEventNotification;
   
   public class HandleUserBannedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUserBannedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:UserBannedEventNotification = messageReceivedEvent.message as UserBannedEventNotification;
         userInfo.chatBanDuration = _loc1_.remainingDuration;
         dispatch(new ChatClientEvent("userBanned"));
      }
   }
}

