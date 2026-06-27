package wom.controller.command.city
{
   import flash.events.IEventDispatcher;
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.component.DefaultCoreManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.message.request.BankGoldRequest;
   import wom.service.logging.WomLoggerContexts;
   
   public class ConstructableActionCommandHelper
   {
      
      public function ConstructableActionCommandHelper()
      {
         super();
      }
      
      public static function findBuildingInfo(param1:int, param2:CityStatusInfo) : BuildingInfo
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.buildings.length)
         {
            if(param2.buildings[_loc3_].instanceId == param1)
            {
               return param2.buildings[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function harvestGold(param1:int, param2:int, param3:SoundPlayer, param4:WomGameRootHolder, param5:IEventDispatcher) : void
      {
         param3.playSfxById("WorkerGotGold");
         var _loc6_:Building = param4.gameRoot.buildings[param2];
         param4.gameRoot.displayFloatingText(DefaultCoreManager.getBuildingProjectedMiddlePoint(_loc6_),11,"" + param1);
         param5.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new BankGoldRequest()));
      }
      
      public static function calculateUnharvestedGoldAmount(param1:int, param2:BuildingInfo, param3:BuildingTypeDIO, param4:UserInfo, param5:CityStatusInfo) : int
      {
         var _loc6_:Number = Number(param3.buildingSpecificInfo[BuildingSpecificInfoType.GOLD_PRODUCTION_PERIODS_IN_HOURS_PER_LEVEL.id][param2.level - 1]);
         var _loc9_:int = int(param3.buildingSpecificInfo[BuildingSpecificInfoType.GOLD_CAPACITY.id]);
         var _loc8_:Number = _loc6_ * _loc9_ * 60 * 60 * 1000 / param4.serverSpeed >> 0;
         var _loc7_:Number = param1 - param5.goldCapacity.updatedTimer > param5.goldCapacity.remainingTime ? 0 : param5.goldCapacity.remainingTime - (param1 - param5.goldCapacity.updatedTimer);
         var _loc10_:int = (_loc8_ - _loc7_) * 4 / _loc8_ >> 0;
         log(WomLoggerContexts.GAME,"Harvesting gold. capacity [" + _loc8_ + "] currentTimer [" + param1 + "] remainingTime [" + _loc7_ + "]  unharvestedAmount [" + _loc10_ + "]");
         return _loc10_;
      }
   }
}

