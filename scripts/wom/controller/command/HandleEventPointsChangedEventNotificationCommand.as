package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.EventPointsChangedEventNotification;
   import wom.model.resource.WomAssetRepository;
   
   public class HandleEventPointsChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function HandleEventPointsChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:EventPointsChangedEventNotification = messageReceivedEvent.message as EventPointsChangedEventNotification;
         userInfo.eventPoints = _loc1_.eventPoints;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("eventPointsUpdated"));
      }
   }
}

