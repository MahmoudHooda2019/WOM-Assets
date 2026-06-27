package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.EventItemQueueChangedEventNotification;
   
   public class HandleEventItemQueueChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleEventItemQueueChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:EventItemDIO = null;
         var _loc3_:EventItemQueueChangedEventNotification = messageReceivedEvent.message as EventItemQueueChangedEventNotification;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 44)
            {
               for each(var _loc2_ in _loc3_.eventItemQueue)
               {
                  _loc4_ = domainInfo.getEventItem(_loc2_.id);
                  _loc2_.originalDuration = originalDurationInMiliSec(_loc4_);
               }
               _loc1_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id] = _loc3_.eventItemQueue;
               break;
            }
         }
         coreManager.manageBlacksmithAnimation();
         dispatch(new ModelUpdateEvent("eventItemQueueUpdated"));
      }
      
      private function getCurrentLevelIndex(param1:EventItemDIO) : int
      {
         var _loc2_:UnitTypeInfo = null;
         var _loc3_:int = 0;
         if(param1.itemType == EventItemType.MERCENARY.id)
         {
            _loc2_ = city.unitTypes[param1.relatedId];
            if(_loc2_)
            {
               _loc3_ = _loc2_.currentLevel - 1;
            }
         }
         return _loc3_;
      }
      
      private function originalDurationInMiliSec(param1:EventItemDIO) : int
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc4_:CatapultTypeDIO = null;
         var _loc3_:int = getCurrentLevelIndex(param1);
         var _loc5_:Number = 0;
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               _loc2_ = domainInfo.getUnit(param1.relatedId);
               _loc5_ = _loc2_.hiringDurationPerLevelInSecs[_loc3_] * 1000;
               break;
            case EventItemType.CATAPULT.id:
               _loc4_ = domainInfo.getCatapult(param1.relatedId);
               _loc5_ = _loc4_.upgradeTimesInSecs.length > 0 ? _loc4_.upgradeTimesInSecs[_loc3_] * 1000 : 0;
         }
         return _loc5_;
      }
   }
}

