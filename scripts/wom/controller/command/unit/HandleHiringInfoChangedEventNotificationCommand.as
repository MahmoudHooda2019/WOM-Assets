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
   import wom.model.message.notification.HiringInfoChangedEventNotification;
   
   public class HandleHiringInfoChangedEventNotificationCommand extends PCommand
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
      
      public function HandleHiringInfoChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BuildingInfo = null;
         var _loc5_:HiringInfoChangedEventNotification = messageReceivedEvent.message as HiringInfoChangedEventNotification;
         var _loc6_:HiringInfoDTO = _loc5_.hiringInfo;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < city.buildings.length && !_loc4_)
         {
            _loc1_ = city.buildings[_loc2_];
            if(_loc1_.instanceId == _loc5_.instanceId)
            {
               _loc4_ = true;
            }
            _loc2_++;
         }
         if(!_loc4_ && _loc5_.instanceId in city.hiringInfoDictionary)
         {
            delete city.hiringInfoDictionary[_loc5_.instanceId];
            _loc3_ = true;
         }
         else
         {
            if(city.hiringInfoDictionary[_loc5_.instanceId] == null)
            {
               city.hiringInfoDictionary[_loc5_.instanceId] = new HiringInfo(_loc6_.hiringBuildingInstanceId,_loc6_.hiringQueue,_loc6_.activeHiring ? new UnitHireJob(_loc6_.activeHiring.unitTypeId,_loc6_.activeHiring.executionTime,_loc6_.activeHiring.remainingDuration,_loc6_.activeHiring.hiringBuildingInstanceId,new Date().getTime(),domainInfo.getUnit(_loc6_.activeHiring.unitTypeId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc6_.activeHiring.unitTypeId] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed) : null,_loc6_.isHiringPaused,_loc6_.pauseReason,_loc6_.lastHiredUnitId);
               _loc3_ = true;
            }
            if(city.hiringInfoDictionary[_loc5_.instanceId].isHiringPaused != _loc6_.isHiringPaused)
            {
               city.hiringInfoDictionary[_loc5_.instanceId].isHiringPaused = _loc6_.isHiringPaused;
               _loc3_ = true;
            }
            if(city.hiringInfoDictionary[_loc5_.instanceId].pauseReason != _loc6_.pauseReason)
            {
               city.hiringInfoDictionary[_loc5_.instanceId].pauseReason = _loc6_.pauseReason;
               _loc3_ = true;
            }
            if(city.hiringInfoDictionary[_loc5_.instanceId].lastHiredUnitId != _loc6_.lastHiredUnitId)
            {
               city.hiringInfoDictionary[_loc5_.instanceId].lastHiredUnitId = _loc6_.lastHiredUnitId;
               _loc3_ = true;
            }
            if(_loc6_.activeHiring == null && city.hiringInfoDictionary[_loc5_.instanceId].activeHiring != null)
            {
               city.hiringInfoDictionary[_loc5_.instanceId].activeHiring = null;
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            if(_loc5_.usesCentralQueue)
            {
               for each(var _loc7_ in city.hiringInfoDictionary)
               {
                  _loc7_.hiringQueue = _loc6_.hiringQueue;
               }
            }
            else
            {
               city.hiringInfoDictionary[_loc5_.instanceId].hiringQueue = _loc6_.hiringQueue;
            }
            dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
            coreManager.manageMercenaryBarracksNotEnoughSpaceIndicator();
            coreManager.manageHiringQuartersAnimations();
         }
      }
   }
}

