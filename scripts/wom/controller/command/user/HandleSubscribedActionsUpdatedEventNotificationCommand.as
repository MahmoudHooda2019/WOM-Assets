package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.SubscribedActionsUpdatedEventNotification;
   
   public class HandleSubscribedActionsUpdatedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleSubscribedActionsUpdatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:SubscribedActionsUpdatedEventNotification = messageReceivedEvent.message as SubscribedActionsUpdatedEventNotification;
         userInfo.subscribedActions = _loc1_.subscribedActions;
         dispatch(new ModelUpdateEvent("subscribedActionsUpdated"));
      }
   }
}

