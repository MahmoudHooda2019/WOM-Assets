package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.RaceStatusChangedEventNotification;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleRaceStatusChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function HandleRaceStatusChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:RaceStatusChangedEventNotification = messageReceivedEvent.message as RaceStatusChangedEventNotification;
         userInfo.eventStartTime = _loc1_.eventStartTime;
         userInfo.eventEndTime = _loc1_.eventEndTime;
         userInfo.eventStoreEndTime = _loc1_.eventStoreEndTime;
         dispatch(new ModelUpdateEvent("eventTimersUpdated"));
      }
   }
}

