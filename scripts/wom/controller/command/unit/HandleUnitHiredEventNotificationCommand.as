package wom.controller.command.unit
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.UnitHiredEventNotification;
   
   public class HandleUnitHiredEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUnitHiredEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc9_:* = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:UnitTypeInfo = null;
         var _loc1_:UnitTypeDIO = null;
         var _loc17_:int = 0;
         var _loc15_:Number = NaN;
         var _loc13_:UnitHiredEventNotification = messageReceivedEvent.message as UnitHiredEventNotification;
         var _loc16_:Dictionary = new Dictionary();
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 19 && _loc2_.level > 0)
            {
               _loc16_[_loc2_.instanceId] = domainInfo.getBuilding(_loc2_.buildingTypeId).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc2_.level - 1];
            }
         }
         for each(var _loc10_ in city.units)
         {
            if(_loc10_.status == UnitStatusType.IN_BARRACKS)
            {
               var _loc19_:int = _loc10_.buildingId;
               var _loc18_:Number = _loc16_[_loc19_] - domainInfo.getUnit(_loc10_.typeId).spacesPerLevel[(city.unitTypes[_loc10_.typeId] as UnitTypeInfo).currentLevel - 1];
               _loc16_[_loc19_] = _loc18_;
            }
         }
         var _loc11_:Number = userInfo.unitArmorModifier;
         var _loc14_:Number = userInfo.unitSpeedModifier;
         var _loc7_:Number = userInfo.unitDamageModifier;
         for each(var _loc4_ in _loc13_.unitAmounts)
         {
            _loc9_ = uint(_loc4_.amount);
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc5_ = -1;
               for(var _loc6_ in _loc16_)
               {
                  if(_loc5_ == -1 || _loc16_[_loc6_] > _loc16_[_loc5_])
                  {
                     _loc5_ = int(_loc6_);
                  }
               }
               _loc12_ = _loc4_.id;
               _loc16_[_loc5_] -= domainInfo.getUnit(_loc12_).spacesPerLevel[(city.unitTypes[_loc12_] as UnitTypeInfo).currentLevel - 1];
               _loc3_ = city.unitTypes[_loc12_];
               _loc1_ = domainInfo.getUnit(_loc12_);
               _loc17_ = _loc3_.currentLevel == 0 ? 0 : _loc3_.currentLevel - 1;
               _loc15_ = _loc1_.healthPointsPerLevel[_loc17_];
               _loc10_ = new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_BARRACKS,_loc5_,_loc12_,_loc15_,_loc11_,_loc14_,_loc7_);
               city.units.push(_loc10_);
               coreManager.hireUnitFromHiringQuartersToBarracks(_loc10_,_loc13_.instanceId);
               _loc8_++;
            }
         }
         dispatch(new ModelUpdateEvent("unitsInBarracksUpdated"));
         updateModelForFinishedHiring();
      }
      
      private function updateModelForFinishedHiring() : void
      {
         var _loc3_:HiringSlotView = null;
         var _loc5_:int = 0;
         var _loc1_:Number = NaN;
         var _loc2_:UnitHiredEventNotification = messageReceivedEvent.message as UnitHiredEventNotification;
         var _loc4_:HiringInfo = city.hiringInfoDictionary[_loc2_.instanceId];
         if(_loc4_)
         {
            if(_loc4_.hiringQueue.hiringSlots.length <= 0)
            {
               _loc4_.activeHiring = null;
            }
            else
            {
               _loc3_ = _loc4_.hiringQueue.hiringSlots[0];
               if(_loc3_.numberOfUnits > 1)
               {
                  _loc3_.numberOfUnits--;
               }
               else if(_loc3_.numberOfUnits == 1)
               {
                  _loc4_.hiringQueue.hiringSlots.splice(0,1);
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_.hiringQueue.hiringSlots.length)
                  {
                     _loc4_.hiringQueue.hiringSlots[_loc5_].slotIndex = _loc5_;
                     _loc5_++;
                  }
               }
               _loc1_ = domainInfo.getUnit(_loc3_.unitId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc3_.unitId] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed;
               _loc4_.activeHiring = new UnitHireJob(_loc3_.unitId,0,_loc1_ * 1000 / userInfo.hiringSpeedModifier >> 0,_loc2_.instanceId,new Date().getTime(),_loc1_);
            }
         }
         dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
      }
   }
}

