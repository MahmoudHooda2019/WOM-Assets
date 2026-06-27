package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.notification.ResourcesChangedEventNotification;
   
   public class HandleResourcesChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleResourcesChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ResourcesChangedEventNotification = messageReceivedEvent.message as ResourcesChangedEventNotification;
         city.resourceAmounts = _loc1_.resources;
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("resourcesUpdated"));
         coreManager.manageStockpileAnimations();
      }
   }
}

