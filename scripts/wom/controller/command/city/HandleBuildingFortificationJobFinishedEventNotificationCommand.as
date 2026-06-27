package wom.controller.command.city
{
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.viral.MobileUserNotification;
   import wom.model.game.viral.UserNotification;
   import wom.model.message.notification.BuildingFortificationJobFinishedEventNotification;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class HandleBuildingFortificationJobFinishedEventNotificationCommand extends PCommand
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
      public var soundPlayer:SoundPlayer;
      
      public function HandleBuildingFortificationJobFinishedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:int = 0;
         var _loc4_:BuildingInfo = null;
         var _loc2_:BuildingTypeDIO = null;
         var _loc3_:UserNotification = null;
         var _loc5_:BuildingFortificationJobFinishedEventNotification = messageReceivedEvent.message as BuildingFortificationJobFinishedEventNotification;
         var _loc1_:Vector.<BuildingUpgradeJob> = city.buildingUpgradeJobs;
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            if(_loc1_[_loc6_].instanceId == _loc5_.buildingFortificationJob.instanceId)
            {
               _loc1_.splice(_loc6_,1);
               break;
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < city.buildings.length)
         {
            _loc4_ = city.buildings[_loc6_];
            if(_loc4_.instanceId == _loc5_.buildingFortificationJob.instanceId)
            {
               _loc4_.fortificationLevel = _loc5_.buildingFortificationJob.targetLevel;
               _loc2_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
               var _temp_7:* = §§findproperty(MobileUserNotification);
               var _temp_6:* = 3;
               var _temp_5:* = 2;
               var _temp_4:* = "";
               var _temp_3:* = "ui.notification.building.fortified";
               var _loc7_:String = "domain.building." + _loc2_.id + ".name";
               var _temp_2:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
               var _loc8_:int = _loc4_.fortificationLevel;
               var _loc9_:* = _temp_2;
               var _loc10_:String = _temp_3;
               _loc3_ = new MobileUserNotification(_temp_6,_temp_5,_temp_4,peak.i18n.PText.INSTANCE.getText2(_loc10_,_loc9_,_loc8_),new MobileBuildingSilhouette(_loc2_.id,_loc4_.level));
               _loc3_.additionalInfo["buildingTypeId"] = _loc2_.id;
               _loc3_.additionalInfo["level"] = _loc4_.fortificationLevel;
               dispatch(new UserNotificationEvent("userNotificationEventShow",_loc3_));
            }
            _loc6_++;
         }
         soundPlayer.playSfxById("UpgradeCompleted");
         coreManager.fortificationUpgradeFinished(_loc5_.buildingFortificationJob.instanceId,_loc5_.buildingFortificationJob.targetLevel);
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("jobsInfoUpdated"));
      }
   }
}

