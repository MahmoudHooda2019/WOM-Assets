package wom.controller.command.city
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.BuildingUpgradeCompletedEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.viral.MobileUserNotification;
   import wom.model.game.viral.UserNotification;
   import wom.model.message.notification.BuildingActivatedEventNotification;
   import wom.view.screen.popups.FeatureAvailablePopUp;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class HandleBuildingActivatedEventNotificationCommand extends PCommand
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
      public var userInfo:UserInfo;
      
      public function HandleBuildingActivatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc4_:UserNotification = null;
         var _loc2_:BuildingActivatedEventNotification = messageReceivedEvent.message as BuildingActivatedEventNotification;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.instanceId == _loc2_.instanceId)
            {
               _loc3_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
               _loc1_.level += 1;
               _loc1_.healthPoint = _loc3_.healthPointsPerLevel[_loc1_.level - 1];
               _loc1_.incomplete = false;
               if(_loc1_.staffs != null)
               {
                  _loc1_.staffs.length = 0;
               }
               if(!_loc3_.multibuild && userInfo.mandatoryTutorialCompleted)
               {
                  if(_loc1_.level > 1)
                  {
                     var _temp_8:* = §§findproperty(MobileUserNotification);
                     var _temp_7:* = 3;
                     var _temp_6:* = 2;
                     var _temp_5:* = _loc3_.silhouetteVisuals[_loc1_.level - 1];
                     var _temp_4:* = "ui.notification.building.upgraded";
                     var _loc7_:String = "domain.building." + _loc3_.id + ".name";
                     var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
                     var _loc8_:int = _loc1_.level;
                     var _loc9_:* = _temp_3;
                     var _loc10_:String = _temp_4;
                     _loc4_ = new MobileUserNotification(_temp_7,_temp_6,_temp_5,peak.i18n.PText.INSTANCE.getText2(_loc10_,_loc9_,_loc8_),new MobileBuildingSilhouette(_loc3_.id,_loc1_.level));
                     _loc4_.additionalInfo["buildingTypeId"] = _loc3_.id;
                     _loc4_.additionalInfo["level"] = _loc1_.level;
                     dispatch(new UserNotificationEvent("userNotificationEventShow",_loc4_));
                  }
                  else
                  {
                     var _temp_14:* = §§findproperty(MobileUserNotification);
                     var _temp_13:* = 3;
                     var _temp_12:* = 1;
                     var _temp_11:* = _loc3_.silhouetteVisuals[_loc1_.level - 1];
                     var _temp_10:* = "ui.notification.building.completed";
                     var _loc11_:String = "domain.building." + _loc3_.id + ".name";
                     var _loc12_:* = peak.i18n.PText.INSTANCE.getText0(_loc11_);
                     var _loc13_:String = _temp_10;
                     _loc4_ = new MobileUserNotification(_temp_13,_temp_12,_temp_11,peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_),new MobileBuildingSilhouette(_loc3_.id,_loc1_.level));
                     _loc4_.additionalInfo["buildingTypeId"] = _loc3_.id;
                     dispatch(new UserNotificationEvent("userNotificationEventShow",_loc4_));
                  }
               }
               dispatch(new BuildingUpgradeCompletedEvent("buildingUpgradeCompleted",_loc1_));
               break;
            }
         }
         coreManager.activateFinished(_loc2_.instanceId);
         dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
         if(_loc1_ && _loc1_.buildingTypeId == 10 && _loc1_.level == 5)
         {
            userInfo.toolMenuEnabled = true;
            dispatch(new ModelUpdateEvent("toolMenuEnabled"));
            dispatch(new PopUpWindowEvent("showPopUpWindow",new FeatureAvailablePopUp(1)));
         }
      }
   }
}

