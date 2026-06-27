package wom.controller.command.city
{
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.notification.BuildingLevelUpgradeJobScheduledEventNotification;
   
   public class HandleBuildingLevelUpgradeJobScheduledEventNotificationCommand extends PCommand
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
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function HandleBuildingLevelUpgradeJobScheduledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:BuildingTypeDIO = null;
         var _loc10_:int = 0;
         var _loc1_:BuildingUpgradeJob = null;
         var _loc8_:BuildingLevelUpgradeJobScheduledEventNotification = messageReceivedEvent.message as BuildingLevelUpgradeJobScheduledEventNotification;
         var _loc4_:Vector.<BuildingUpgradeJob> = city.buildingUpgradeJobs;
         var _loc9_:Boolean = false;
         var _loc11_:BuildingUpgradeJobDTO = _loc8_.buildingLevelUpgradeJob;
         var _loc7_:int = _loc11_.targetLevel == 0 ? 0 : _loc11_.targetLevel - 1;
         if(_loc8_.buildingInfo)
         {
            _loc6_ = domainInfo.getBuilding(_loc8_.buildingInfo.buildingTypeId);
         }
         else
         {
            for each(var _loc3_ in city.buildings)
            {
               if(_loc3_.instanceId == _loc11_.instanceId)
               {
                  _loc6_ = domainInfo.getBuilding(_loc3_.buildingTypeId);
                  break;
               }
            }
         }
         var _loc2_:Number = _loc6_.upgradeDurationsPerLevel[_loc7_];
         var _loc5_:Number = _loc2_ * 1000 / userInfo.serverSpeed;
         _loc10_ = 0;
         while(_loc10_ < _loc4_.length)
         {
            if(_loc4_[_loc10_].instanceId == _loc8_.buildingLevelUpgradeJob.instanceId)
            {
               _loc4_[_loc10_] = new BuildingUpgradeJob(_loc11_.instanceId,_loc11_.targetLevel,_loc11_.durationRemaining,_loc5_,BuildingUpgradeJobType.UPGRADE,new Date().getTime());
               _loc9_ = true;
            }
            _loc10_++;
         }
         if(!_loc9_)
         {
            _loc1_ = new BuildingUpgradeJob(_loc11_.instanceId,_loc11_.targetLevel,_loc11_.durationRemaining,_loc5_,BuildingUpgradeJobType.UPGRADE,new Date().getTime());
            _loc4_.push(_loc1_);
            if(_loc11_.targetLevel == 1 && !(_loc8_.buildingLevelUpgradeJob.instanceId in city.interruptedConstructionJobs))
            {
               if(domainInfo.getBuilding(_loc8_.buildingInfo.buildingTypeId).kind.id == 11)
               {
                  _loc8_.buildingInfo.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = 0;
               }
               city.buildings.push(_loc8_.buildingInfo);
               coreManager.addBuilding(_loc8_.buildingInfo,_loc1_);
               coreManager.manageResourceProducerAnimations();
               dispatch(new ModelUpdateEvent("buildingTypesUpdated"));
            }
            else
            {
               if(_loc8_.buildingLevelUpgradeJob.instanceId in city.interruptedConstructionJobs)
               {
                  delete city.interruptedConstructionJobs[_loc8_.buildingLevelUpgradeJob.instanceId];
               }
               coreManager.manageResourceProducerAnimations();
               coreManager.startUpgrade(_loc11_.instanceId,_loc1_);
            }
            if(_loc11_.targetLevel == 1 && _loc8_.buildingInfo && _loc8_.buildingInfo.buildingTypeId == 44)
            {
               coreManager.manageBlacksmithAnimation();
            }
         }
         soundPlayer.playSfxById("ConstructionStarted");
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("jobsInfoUpdated"));
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
   }
}

