package wom.controller.command.city
{
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.job.BuildingUpgradeJobDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.notification.BuildingFortificationJobScheduledNotification;
   
   public class HandleBuildingFortificationJobScheduledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function HandleBuildingFortificationJobScheduledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:BuildingTypeDIO = null;
         var _loc11_:int = 0;
         var _loc1_:BuildingUpgradeJob = null;
         var _loc9_:BuildingFortificationJobScheduledNotification = messageReceivedEvent.message as BuildingFortificationJobScheduledNotification;
         var _loc4_:Vector.<BuildingUpgradeJob> = city.buildingUpgradeJobs;
         var _loc10_:Boolean = false;
         var _loc8_:BuildingUpgradeJobDTO = _loc9_.buildingFortificationJob;
         var _loc7_:int = _loc8_.targetLevel == 0 ? 0 : _loc8_.targetLevel - 1;
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.instanceId == _loc8_.instanceId)
            {
               _loc6_ = domainInfo.getBuilding(_loc3_.buildingTypeId);
               break;
            }
         }
         var _loc2_:Number = (_loc6_.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO).fortifyDurationsPerLevelInSecs[_loc7_];
         var _loc5_:Number = _loc2_ * 1000 / userInfo.serverSpeed;
         _loc11_ = 0;
         while(_loc11_ < _loc4_.length)
         {
            if(_loc4_[_loc11_].instanceId == _loc9_.buildingFortificationJob.instanceId)
            {
               _loc4_[_loc11_] = new BuildingUpgradeJob(_loc8_.instanceId,_loc8_.targetLevel,_loc8_.durationRemaining,_loc5_,BuildingUpgradeJobType.FORTIFY,new Date().getTime());
               _loc10_ = true;
            }
            _loc11_++;
         }
         if(!_loc10_)
         {
            _loc1_ = new BuildingUpgradeJob(_loc8_.instanceId,_loc8_.targetLevel,_loc8_.durationRemaining,_loc5_,BuildingUpgradeJobType.FORTIFY,new Date().getTime());
            _loc4_.push(_loc1_);
            coreManager.startUpgrade(_loc8_.instanceId,_loc1_);
         }
         soundPlayer.playSfxById("ConstructionStarted");
         dispatch(new ModelUpdateEvent("fortificationJobsInfoUpdated"));
      }
   }
}

