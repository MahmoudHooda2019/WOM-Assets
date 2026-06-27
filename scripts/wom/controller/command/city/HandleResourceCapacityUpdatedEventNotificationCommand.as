package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.ResourceCapacityUpdatedEventNotification;
   
   public class HandleResourceCapacityUpdatedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleResourceCapacityUpdatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ResourceCapacityUpdatedEventNotification = messageReceivedEvent.message as ResourceCapacityUpdatedEventNotification;
         city.totalResourceCapacity = _loc1_.newCapacity;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("resourceCapacityUpdated"));
         coreManager.manageStockpileAnimations();
      }
   }
}

