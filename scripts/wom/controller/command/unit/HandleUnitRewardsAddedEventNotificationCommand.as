package wom.controller.command.unit
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.UnitRewardsAddedEventNotification;
   
   public class HandleUnitRewardsAddedEventNotificationCommand extends PCommand
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
      
      public function HandleUnitRewardsAddedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:UnitTypeInfo = null;
         var _loc1_:UnitTypeDIO = null;
         var _loc16_:int = 0;
         var _loc14_:Number = NaN;
         var _loc12_:UnitRewardsAddedEventNotification = messageReceivedEvent.message as UnitRewardsAddedEventNotification;
         var _loc15_:Dictionary = new Dictionary();
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 19 && _loc2_.level > 0)
            {
               _loc15_[_loc2_.instanceId] = domainInfo.getBuilding(_loc2_.buildingTypeId).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc2_.level - 1];
            }
         }
         for each(var _loc9_ in city.units)
         {
            if(_loc9_.status == UnitStatusType.IN_BARRACKS)
            {
               var _loc18_:int = _loc9_.buildingId;
               var _loc17_:Number = _loc15_[_loc18_] - domainInfo.getUnit(_loc9_.typeId).spacesPerLevel[(city.unitTypes[_loc9_.typeId] as UnitTypeInfo).currentLevel - 1];
               _loc15_[_loc18_] = _loc17_;
            }
         }
         var _loc8_:uint = uint(_loc12_.amount);
         var _loc10_:Number = userInfo.unitArmorModifier;
         var _loc13_:Number = userInfo.unitSpeedModifier;
         var _loc6_:Number = userInfo.unitDamageModifier;
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc4_ = -1;
            for(var _loc5_ in _loc15_)
            {
               if(_loc4_ == -1 || _loc15_[_loc5_] > _loc15_[_loc4_])
               {
                  _loc4_ = int(_loc5_);
               }
            }
            _loc11_ = _loc12_.unitTypeId;
            _loc15_[_loc4_] -= domainInfo.getUnit(_loc11_).spacesPerLevel[(city.unitTypes[_loc11_] as UnitTypeInfo).currentLevel - 1];
            _loc3_ = city.unitTypes[_loc11_];
            _loc1_ = domainInfo.getUnit(_loc11_);
            _loc16_ = _loc3_.currentLevel == 0 ? 0 : _loc3_.currentLevel - 1;
            _loc14_ = _loc1_.healthPointsPerLevel[_loc16_];
            _loc9_ = new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_BARRACKS,_loc4_,_loc11_,_loc14_,_loc10_,_loc13_,_loc6_);
            city.units.push(_loc9_);
            if(_loc12_.questId == 20)
            {
               coreManager.assignUnitToBarracks(_loc9_);
            }
            else
            {
               coreManager.assignUnitToBarracks(_loc9_);
            }
            _loc7_++;
         }
      }
   }
}

