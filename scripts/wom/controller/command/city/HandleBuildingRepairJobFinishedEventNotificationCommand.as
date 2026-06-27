package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.job.BuildingRepairJobDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.message.notification.BuildingRepairJobFinishedEventNotification;
   
   public class HandleBuildingRepairJobFinishedEventNotificationCommand extends PCommand
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
      
      public function HandleBuildingRepairJobFinishedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:int = 0;
         var _loc4_:BuildingRepairJobFinishedEventNotification = messageReceivedEvent.message as BuildingRepairJobFinishedEventNotification;
         var _loc1_:Vector.<BuildingRepairJob> = city.buildingRepairJobs;
         var _loc3_:BuildingRepairJobDTO = _loc4_.buildingRepairJob;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_].instanceId == _loc3_.instanceId)
            {
               _loc1_.splice(_loc5_,1);
               break;
            }
            _loc5_++;
         }
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.instanceId == _loc3_.instanceId)
            {
               _loc2_.healthPoint = domainInfo.getBuilding(_loc2_.buildingTypeId).healthPointsPerLevel[_loc2_.level == 0 ? 0 : _loc2_.level - 1];
               break;
            }
         }
         if(_loc3_.instanceId in city.interruptedConstructionJobs)
         {
            delete city.interruptedConstructionJobs[_loc3_.instanceId];
         }
         coreManager.endRepair(_loc3_.instanceId);
         coreManager.manageIncompleteBuildingIndicators();
         coreManager.manageResourceProducerAnimations();
         dispatch(new ModelUpdateEvent("repairJobsUpdated"));
         if(userInfo.npcAttackStatus == NPCAttackStatus.POSTPONED_FROM_UNHEALTHY_BUILDING)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.WAIT;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
         }
      }
   }
}

