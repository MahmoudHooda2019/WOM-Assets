package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.ReconPointsChangedEventNotification;
   
   public class HandleReconPointsChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleReconPointsChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ReconPointsChangedEventNotification = messageReceivedEvent.message as ReconPointsChangedEventNotification;
         userInfo.reconPoints = _loc1_.reconPoints;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("reconPoinrsUpdated"));
      }
   }
}

