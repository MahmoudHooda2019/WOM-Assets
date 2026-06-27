package wom.controller.command.city
{
   import flash.utils.getTimer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.GoldCapacityInfo;
   import wom.model.message.notification.GoldBankedEventNotification;
   
   public class HandleGoldBankedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleGoldBankedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:GoldBankedEventNotification = messageReceivedEvent.message as GoldBankedEventNotification;
         city.goldCapacity = new GoldCapacityInfo(_loc2_.remainingTime,getTimer());
         if(_loc2_.bankedGold > 0)
         {
            for each(var _loc1_ in city.buildings)
            {
               if(_loc1_.buildingTypeId == 10)
               {
                  coreManager.harvest(_loc1_.instanceId,_loc2_.bankedGold);
                  coreManager.manageCityCenterIndicatorStatus();
               }
            }
         }
         eventDispatcher.dispatchEvent(new ModelUpdateEvent("goldCapacityRemainingTimeUpdated"));
      }
   }
}

