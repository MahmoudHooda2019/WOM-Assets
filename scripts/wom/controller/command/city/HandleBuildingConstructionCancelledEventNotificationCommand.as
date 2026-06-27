package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.notification.BuildingConstructionCancelledEventNotification;
   
   public class HandleBuildingConstructionCancelledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleBuildingConstructionCancelledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = undefined;
         var _loc6_:* = undefined;
         var _loc5_:BuildingUpgradeJob = null;
         var _loc7_:int = 0;
         var _loc3_:BuildingInfo = null;
         var _loc4_:BuildingConstructionCancelledEventNotification = messageReceivedEvent.message as BuildingConstructionCancelledEventNotification;
         var _loc8_:Vector.<BuildingRepairJob> = city.buildingRepairJobs;
         var _loc1_:Vector.<BuildingUpgradeJob> = city.buildingUpgradeJobs;
         _loc9_ = 0;
         while(_loc9_ < _loc8_.length)
         {
            if(_loc8_[_loc9_].instanceId == _loc4_.instanceId)
            {
               _loc2_ = _loc8_.splice(_loc9_,1);
               coreManager.endRepair(_loc2_[0].instanceId);
               dispatch(new ModelUpdateEvent("repairJobsUpdated"));
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc1_.length)
         {
            if(_loc1_[_loc9_].instanceId == _loc4_.instanceId)
            {
               _loc6_ = _loc1_.splice(_loc9_,1);
               coreManager.upgradeCancelled(_loc4_.instanceId);
               _loc5_ = _loc6_[0];
               if(_loc5_.type == BuildingUpgradeJobType.UPGRADE)
               {
                  dispatch(new ModelUpdateEvent("jobsInfoUpdated"));
                  _loc7_ = 0;
                  while(_loc7_ < city.buildings.length)
                  {
                     _loc3_ = city.buildings[_loc7_];
                     if(_loc3_.instanceId == _loc5_.instanceId)
                     {
                        if(_loc5_.targetLevel == 1)
                        {
                           city.buildings.splice(_loc7_,1);
                           coreManager.removeBuilding(_loc5_.instanceId);
                           break;
                        }
                        _loc3_.incomplete = false;
                     }
                     _loc7_++;
                  }
               }
               else if(_loc5_.type == BuildingUpgradeJobType.FORTIFY)
               {
                  dispatch(new ModelUpdateEvent("fortificationJobsInfoUpdated"));
               }
               break;
            }
            _loc9_++;
         }
         coreManager.manageResourceProducerAnimations();
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
      }
   }
}

