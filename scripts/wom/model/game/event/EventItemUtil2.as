package wom.model.game.event
{
   import org.robotlegs.mvcs.Actor;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class EventItemUtil2 extends Actor
   {
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function EventItemUtil2()
      {
         super();
      }
      
      public static function isEventItemLocked(param1:EventItemDIO, param2:Vector.<int>) : Boolean
      {
         var _loc4_:Boolean = true;
         for each(var _loc3_ in param2)
         {
            if(param1 == null)
            {
               return false;
            }
            if(_loc3_ == param1.id)
            {
               _loc4_ = false;
               break;
            }
         }
         return _loc4_;
      }
      
      public function isUnlocked(param1:UnitTypeDIO, param2:UnitTypeInfo) : Boolean
      {
         if(!param1.event)
         {
            return param2.recruited;
         }
         var _loc3_:EventItemDIO = getEventItemDIO(param1);
         if(!_loc3_)
         {
            return false;
         }
         if(!userInfo.unlockedEventItems)
         {
            return false;
         }
         for each(var _loc4_ in userInfo.unlockedEventItems)
         {
            if(_loc4_ == _loc3_.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getEventItemDIO(param1:UnitTypeDIO) : EventItemDIO
      {
         if(param1)
         {
            for each(var _loc2_ in domainInfo.getEventItems())
            {
               if(_loc2_.itemType == EventItemType.MERCENARY.id && _loc2_.relatedId == param1.id)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getCurrentLevelIndex(param1:EventItemDIO) : int
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
      
      public function getUnitTypeInfo(param1:EventItemDIO) : UnitTypeInfo
      {
         var _loc2_:UnitTypeDIO = null;
         if(param1.itemType == EventItemType.MERCENARY.id)
         {
            _loc2_ = domainInfo.getUnit(param1.relatedId);
            return city.unitTypes[_loc2_.id];
         }
         return null;
      }
      
      public function getEventItems() : Vector.<Object>
      {
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc2_ in domainInfo.getEventItems())
         {
            _loc1_.push({
               "eventItemDIO":_loc2_,
               "unitTypeInfo":getUnitTypeInfo(_loc2_)
            });
         }
         return _loc1_;
      }
      
      public function getInventoryEventItems() : Vector.<Object>
      {
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         var _loc1_:Vector.<EventInventoryItemInfo> = new Vector.<EventInventoryItemInfo>();
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 44)
            {
               _loc1_ = _loc2_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id];
            }
         }
         for each(var _loc4_ in _loc1_)
         {
            _loc3_.push({
               "itemInfo":_loc4_,
               "itemDIO":domainInfo.getEventItem(_loc4_.id)
            });
         }
         return _loc3_;
      }
   }
}

