package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.GoldAmountChangedEventNotification;
   
   public class HandleGoldAmountChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleGoldAmountChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GoldAmountChangedEventNotification = messageReceivedEvent.message as GoldAmountChangedEventNotification;
         userInfo.numberOfGolds = _loc1_.numberOfGolds;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("goldAmountUpdated"));
      }
   }
}

