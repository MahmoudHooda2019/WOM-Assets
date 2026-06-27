package wom.controller.command.city
{
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.BuildingUpgradeCompletedEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.viral.MobileUserNotification;
   import wom.model.game.viral.UserNotification;
   import wom.model.message.notification.BuildingLevelUpgradeJobFinishedEventNotification;
   import wom.view.screen.popups.FeatureAvailablePopUp;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class HandleBuildingLevelUpgradeJobFinishedEventNotificationCommand extends PCommand
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
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleBuildingLevelUpgradeJobFinishedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc9_:UserNotification = null;
         var _loc11_:int = 0;
         var _loc2_:BuildingInfo = null;
         var _loc3_:BuildingInfo = null;
         var _loc10_:BuildingLevelUpgradeJobFinishedEventNotification = messageReceivedEvent.message as BuildingLevelUpgradeJobFinishedEventNotification;
         var _loc4_:Vector.<BuildingUpgradeJob> = city.buildingUpgradeJobs;
         var _loc8_:int = _loc10_.buildingLevelUpgradeJob.targetLevel - 1;
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         var _loc1_:Boolean = _loc10_.buildingIncomplete;
         var _loc7_:BuildingTypeDIO = domainInfo.getBuilding(_loc10_.buildingInfo.buildingTypeId);
         var _loc5_:int = _loc7_.healthPointsPerLevel[_loc8_];
         var _loc6_:Boolean = false;
         _loc11_ = 0;
         while(_loc11_ < _loc4_.length)
         {
            if(_loc4_[_loc11_].instanceId == _loc10_.buildingLevelUpgradeJob.instanceId)
            {
               _loc4_.splice(_loc11_,1);
               break;
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < city.buildings.length)
         {
            _loc2_ = city.buildings[_loc11_];
            if(_loc2_.instanceId == _loc10_.buildingLevelUpgradeJob.instanceId)
            {
               _loc6_ = true;
               _loc2_.incomplete = _loc1_;
               if(!_loc1_)
               {
                  (_loc2_ as BuildingInfo).level = _loc10_.buildingLevelUpgradeJob.targetLevel;
                  _loc2_.healthPoint = _loc5_;
                  if(!_loc7_.multibuild && userInfo.mandatoryTutorialCompleted)
                  {
                     if(_loc2_.level > 1)
                     {
                        var _temp_9:* = §§findproperty(MobileUserNotification);
                        var _temp_8:* = 3;
                        var _temp_7:* = 2;
                        var _temp_6:* = _loc7_.silhouetteVisuals[_loc2_.level - 1];
                        var _temp_5:* = "ui.notification.building.upgraded";
                        var _loc12_:String = "domain.building." + _loc7_.id + ".name";
                        var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc12_);
                        var _loc13_:int = _loc2_.level;
                        var _loc14_:* = _temp_4;
                        var _loc15_:String = _temp_5;
                        _loc9_ = new MobileUserNotification(_temp_8,_temp_7,_temp_6,peak.i18n.PText.INSTANCE.getText2(_loc15_,_loc14_,_loc13_),new MobileBuildingSilhouette(_loc7_.id,_loc2_.level));
                        _loc9_.additionalInfo["buildingTypeId"] = _loc7_.id;
                        _loc9_.additionalInfo["level"] = _loc2_.level;
                        dispatch(new UserNotificationEvent("userNotificationEventShow",_loc9_));
                     }
                     else
                     {
                        var _temp_15:* = §§findproperty(MobileUserNotification);
                        var _temp_14:* = 3;
                        var _temp_13:* = 1;
                        var _temp_12:* = _loc7_.silhouetteVisuals[_loc2_.level - 1];
                        var _temp_11:* = "ui.notification.building.completed";
                        var _loc16_:String = "domain.building." + _loc7_.id + ".name";
                        var _loc17_:* = peak.i18n.PText.INSTANCE.getText0(_loc16_);
                        var _loc18_:String = _temp_11;
                        _loc9_ = new MobileUserNotification(_temp_14,_temp_13,_temp_12,peak.i18n.PText.INSTANCE.getText1(_loc18_,_loc17_),new MobileBuildingSilhouette(_loc7_.id,_loc2_.level));
                        _loc9_.additionalInfo["buildingTypeId"] = _loc7_.id;
                        dispatch(new UserNotificationEvent("userNotificationEventShow",_loc9_));
                     }
                  }
                  dispatch(new BuildingUpgradeCompletedEvent("buildingUpgradeCompleted",_loc2_));
               }
               if(_loc2_ && _loc2_.buildingTypeId == 10 && _loc2_.level == 5)
               {
                  userInfo.toolMenuEnabled = true;
                  dispatch(new ModelUpdateEvent("toolMenuEnabled"));
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new FeatureAvailablePopUp(1)));
               }
               break;
            }
            _loc11_++;
         }
         if(_loc6_)
         {
            coreManager.upgradeFinished(_loc10_.buildingLevelUpgradeJob.instanceId);
         }
         else
         {
            if(domainInfo.getBuilding(_loc10_.buildingInfo.buildingTypeId).kind.id == 11)
            {
               _loc10_.buildingInfo.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = 0;
            }
            _loc3_ = _loc10_.buildingInfo;
            if(_loc3_ && _loc3_.buildingTypeId == 26)
            {
               dispatch(new PopUpWindowEvent("showPopUpWindow",new FeatureAvailablePopUp(2)));
            }
            city.buildings.push(_loc3_);
            (city.buildingTypes[_loc3_.buildingTypeId] as BuildingTypeInfo).currentInstanceCount++;
            coreManager.addBuilding(_loc3_,null,null,true);
            dispatch(new ModelUpdateEvent("buildingTypesUpdated"));
            if(!_loc1_)
            {
               if(!_loc7_.multibuild && userInfo.mandatoryTutorialCompleted)
               {
                  var _temp_26:* = §§findproperty(MobileUserNotification);
                  var _temp_25:* = 3;
                  var _temp_24:* = 1;
                  var _temp_23:* = _loc7_.silhouetteVisuals[_loc3_.level - 1];
                  var _temp_22:* = "ui.notification.building.completed";
                  var _loc19_:String = "domain.building." + _loc7_.id + ".name";
                  var _loc20_:* = peak.i18n.PText.INSTANCE.getText0(_loc19_);
                  var _loc21_:String = _temp_22;
                  _loc9_ = new MobileUserNotification(_temp_25,_temp_24,_temp_23,peak.i18n.PText.INSTANCE.getText1(_loc21_,_loc20_),new MobileBuildingSilhouette(_loc7_.id,_loc3_.level));
                  _loc9_.additionalInfo["buildingTypeId"] = _loc7_.id;
                  dispatch(new UserNotificationEvent("userNotificationEventShow",_loc9_));
               }
               dispatch(new BuildingUpgradeCompletedEvent("buildingUpgradeCompleted",_loc3_));
            }
            if(_loc3_.buildingTypeId == 29 && userInfo.tutorialsInfo.additionalInfo.beastCageStatus == 0)
            {
               coreManager.freeCagedBeast(_loc3_.instanceId);
            }
         }
         if(_loc7_.upgradeDurationsPerLevel[_loc8_] > 0)
         {
            soundPlayer.playSfxById("UpgradeCompleted");
         }
         coreManager.manageResourceProducerAnimations();
         if(_loc10_.buildingInfo && _loc10_.buildingInfo.buildingTypeId == 44)
         {
            coreManager.manageBlacksmithAnimation();
         }
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
         dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
         dispatch(new ModelUpdateEvent("jobsInfoUpdated"));
      }
   }
}

