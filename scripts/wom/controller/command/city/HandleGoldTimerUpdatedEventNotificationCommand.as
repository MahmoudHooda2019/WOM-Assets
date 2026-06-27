package wom.controller.command.city
{
   import flash.utils.getTimer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.resource.GoldCapacityInfo;
   import wom.model.message.notification.GoldTimerUpdatedEventNotification;
   
   public class HandleGoldTimerUpdatedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleGoldTimerUpdatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GoldTimerUpdatedEventNotification = messageReceivedEvent.message as GoldTimerUpdatedEventNotification;
         city.goldCapacity = new GoldCapacityInfo(_loc1_.remainingTime,getTimer());
         coreManager.manageCityCenterIndicatorStatus();
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("goldCapacityRemainingTimeUpdated"));
      }
   }
}

