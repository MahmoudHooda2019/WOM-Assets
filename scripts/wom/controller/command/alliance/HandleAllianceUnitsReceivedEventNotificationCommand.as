package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.alliance.AllianceUnitsReceivedEventNotification;
   
   public class HandleAllianceUnitsReceivedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleAllianceUnitsReceivedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc8_:* = 0;
         var _loc7_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:UnitTypeInfo = null;
         var _loc1_:UnitTypeDIO = null;
         var _loc16_:int = 0;
         var _loc15_:Number = NaN;
         var _loc9_:UnitInfo = null;
         var _loc13_:AllianceUnitsReceivedEventNotification = messageReceivedEvent.message as AllianceUnitsReceivedEventNotification;
         var _loc2_:int = -1;
         var _loc6_:int = -1;
         for each(var _loc11_ in city.buildings)
         {
            if(_loc11_.buildingTypeId == 42)
            {
               _loc2_ = _loc11_.instanceId;
            }
            if(_loc11_.buildingTypeId == 43)
            {
               _loc6_ = _loc11_.instanceId;
            }
         }
         var _loc10_:Number = userInfo.unitArmorModifier;
         var _loc14_:Number = userInfo.unitSpeedModifier;
         var _loc5_:Number = userInfo.unitDamageModifier;
         for each(var _loc4_ in _loc13_.unitAmounts)
         {
            _loc8_ = uint(_loc4_.amount);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc12_ = _loc4_.id;
               _loc3_ = city.unitTypes[_loc12_];
               _loc1_ = domainInfo.getUnit(_loc12_);
               _loc16_ = _loc3_.currentLevel == 0 ? 0 : _loc3_.currentLevel - 1;
               _loc15_ = _loc1_.healthPointsPerLevel[_loc16_];
               _loc9_ = new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_ALLIANCE_BARRACKS,_loc6_,_loc12_,_loc15_,_loc10_,_loc14_,_loc5_);
               city.units.push(_loc9_);
               coreManager.hireUnitFromHiringQuartersToBarracks(_loc9_,_loc2_);
               _loc7_++;
            }
         }
         dispatch(new ModelUpdateEvent("unitsInAllianceBarracksUpdated"));
      }
   }
}

