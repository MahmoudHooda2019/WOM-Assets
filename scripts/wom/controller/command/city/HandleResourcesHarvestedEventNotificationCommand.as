package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.message.notification.ResourcesHarvestedEventNotification;
   
   public class HandleResourcesHarvestedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleResourcesHarvestedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Number = NaN;
         var _loc3_:ResourcesHarvestedEventNotification = messageReceivedEvent.message as ResourcesHarvestedEventNotification;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.instanceId in _loc3_.currentStocks)
            {
               _loc1_ = Number(_loc3_.currentStocks[_loc2_.instanceId]);
               _loc2_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = _loc1_;
            }
         }
         coreManager.manageResourceProducerAnimations();
      }
   }
}

