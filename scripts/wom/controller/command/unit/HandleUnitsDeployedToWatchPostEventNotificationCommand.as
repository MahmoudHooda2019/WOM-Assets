package wom.controller.command.unit
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
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.UnitsDeployedToWatchPostEventNotification;
   
   public class HandleUnitsDeployedToWatchPostEventNotificationCommand extends PCommand
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
      
      public function HandleUnitsDeployedToWatchPostEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc10_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:* = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:UnitTypeInfo = null;
         var _loc2_:UnitTypeDIO = null;
         var _loc15_:int = 0;
         var _loc14_:Number = NaN;
         var _loc9_:UnitInfo = null;
         var _loc12_:UnitsDeployedToWatchPostEventNotification = messageReceivedEvent.message as UnitsDeployedToWatchPostEventNotification;
         if(_loc12_.unitDeploymentSource == 1)
         {
            for each(var _loc5_ in _loc12_.unitAmounts)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.amount)
               {
                  for each(var _loc1_ in city.units)
                  {
                     if(_loc1_.status == UnitStatusType.IN_BARRACKS && _loc5_.id == _loc1_.typeId)
                     {
                        coreManager.deployUnitToWatchPostFromBarracks(_loc1_.instanceId,_loc12_.instanceId);
                        _loc1_.status = UnitStatusType.IN_WATCH_POST;
                        _loc1_.buildingId = _loc12_.instanceId;
                        break;
                     }
                  }
                  _loc3_++;
               }
            }
         }
         else
         {
            _loc10_ = userInfo.unitArmorModifier;
            _loc13_ = userInfo.unitSpeedModifier;
            _loc6_ = userInfo.unitDamageModifier;
            for each(_loc5_ in _loc12_.unitAmounts)
            {
               _loc8_ = uint(_loc5_.amount);
               _loc7_ = 0;
               while(_loc7_ < _loc8_)
               {
                  _loc11_ = _loc5_.id;
                  _loc4_ = city.unitTypes[_loc11_];
                  _loc2_ = domainInfo.getUnit(_loc11_);
                  _loc15_ = _loc4_.currentLevel == 0 ? 0 : _loc4_.currentLevel - 1;
                  _loc14_ = _loc2_.healthPointsPerLevel[_loc15_];
                  _loc9_ = new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_WATCH_POST,_loc12_.instanceId,_loc11_,_loc14_,_loc10_,_loc13_,_loc6_);
                  city.units.push(_loc9_);
                  coreManager.deployUnitToWatchPostFromStore(_loc9_,_loc12_.instanceId);
                  _loc7_++;
               }
            }
         }
         dispatch(new ModelUpdateEvent("unitsInWatchPostUpdated"));
      }
   }
}

