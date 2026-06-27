package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.HiringInfoDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.GetHiringStatusResponse;
   
   public class HandleGetHiringStatusResponseCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleGetHiringStatusResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc1_:BuildingInfo = null;
         var _loc4_:GetHiringStatusResponse = messageReceivedEvent.message as GetHiringStatusResponse;
         for each(var _loc5_ in _loc4_.hiringInfo)
         {
            _loc3_ = false;
            _loc2_ = 0;
            while(_loc2_ < city.buildings.length && !_loc3_)
            {
               _loc1_ = city.buildings[_loc2_];
               if(_loc1_.instanceId == _loc5_.hiringBuildingInstanceId)
               {
                  _loc3_ = true;
               }
               _loc2_++;
            }
            if(!_loc3_ && _loc4_.instanceId in city.hiringInfoDictionary)
            {
               delete city.hiringInfoDictionary[_loc4_.instanceId];
            }
            else
            {
               city.hiringInfoDictionary[_loc5_.hiringBuildingInstanceId] = new HiringInfo(_loc5_.hiringBuildingInstanceId,_loc5_.hiringQueue,_loc5_.activeHiring ? new UnitHireJob(_loc5_.activeHiring.unitTypeId,_loc5_.activeHiring.executionTime,_loc5_.activeHiring.remainingDuration,_loc5_.activeHiring.hiringBuildingInstanceId,new Date().getTime(),domainInfo.getUnit(_loc5_.activeHiring.unitTypeId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc5_.activeHiring.unitTypeId] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed) : null,_loc5_.isHiringPaused,_loc5_.pauseReason,_loc5_.lastHiredUnitId);
            }
         }
         if(_loc4_.usesCentralQueue)
         {
            for each(var _loc6_ in city.hiringInfoDictionary)
            {
               _loc6_.hiringQueue = _loc5_.hiringQueue;
            }
         }
         dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
         coreManager.manageMercenaryBarracksNotEnoughSpaceIndicator();
         coreManager.manageHiringQuartersAnimations();
      }
   }
}

