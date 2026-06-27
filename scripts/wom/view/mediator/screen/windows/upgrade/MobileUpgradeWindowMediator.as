package wom.view.mediator.screen.windows.upgrade
{
   import flash.events.Event;
   import flash.geom.Point;
   import peak.i18n.PText;
   import peak.messaging.OutgoingMessage;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.UpgradeBuildingRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.upgrade.MobileUpgradeWindow;
   
   public class MobileUpgradeWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileUpgradeWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileUpgradeWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.serverSpeed = userInfo.serverSpeed;
         super.onRegister();
         addContextListener("gotostore",goToStore);
         eventMap.mapStarlingListener(view.upgradeWithResourcesButton,"triggered",onUpgradeWithResourcesClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.upgradeWithGoldButton,"triggered",onUpgradeWithGoldClicked,starling.events.Event);
         addContextListener("resourcesUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         updateWindow();
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.upgradeWithResourcesButton.localToGlobal(new Point()),param1.additionalInfo,view.upgradeWithResourcesButton));
      }
      
      private function goToStore(param1:flash.events.Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":0,
            "page":0
         }));
         closeWindow();
      }
      
      private function onResourcesUpdated(param1:ModelUpdateEvent) : void
      {
         updateWindow();
      }
      
      private function onUpgradeWithGoldClicked(param1:starling.events.Event) : void
      {
         if(!view.requirementsSatisfied)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "m.ui.warning.requirementsnotmet";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         else
         {
            upgradeBuilding(true);
         }
      }
      
      private function onUpgradeWithResourcesClicked(param1:starling.events.Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(!view.requirementsSatisfied)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc9_:String = "m.ui.warning.requirementsnotmet";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc9_)));
            return;
         }
         if(view.resourcesSatisfied)
         {
            upgradeBuilding();
         }
         else
         {
            _loc5_ = 0;
            _loc3_ = [];
            for each(var _loc2_ in view.buildingTypeDIO.resourceCosts[view.buildingInfo.level])
            {
               _loc6_ = _loc2_.resourceAmount - city.resourceAmounts[_loc2_.resourceType];
               if(_loc6_ > 0)
               {
                  _loc3_.push({
                     "resourceType":_loc2_.resourceType,
                     "amount":_loc6_
                  });
                  _loc5_ += _loc6_;
               }
            }
            _loc4_ = StoreUtil.resourcePrice(_loc5_);
            upgradeBuilding(false,_loc4_,_loc3_);
         }
      }
      
      private function upgradeBuilding(param1:Boolean = false, param2:int = 0, param3:Array = null) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:OutgoingMessage = null;
         if(view.buildingInfo.buildingTypeId == 17 && city.activeRecruitJob)
         {
            var _temp_3:* = §§findproperty(MobileUINotificationEvent);
            var _temp_2:* = "mobileUINotificationEventShow";
            var _loc9_:String = "ui.popups.actionnotpossible.type.86";
            dispatch(new MobileUINotificationEvent(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc9_)));
            return;
         }
         if(view.buildingInfo.buildingTypeId == 18)
         {
            _loc6_ = false;
            for each(var _loc5_ in city.unitTrainJobs)
            {
               if(_loc5_.instanceId == view.buildingInfo.instanceId)
               {
                  _loc6_ = true;
                  break;
               }
            }
            if(_loc6_)
            {
               var _temp_7:* = §§findproperty(MobileUINotificationEvent);
               var _temp_6:* = "mobileUINotificationEventShow";
               var _loc10_:String = "ui.popups.actionnotpossible.type.85";
               dispatch(new MobileUINotificationEvent(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc10_)));
               return;
            }
         }
         if(param1)
         {
            if(userInfo.numberOfGolds < StoreUtil.buildingPriceWithRequirementsVector(view.buildingTypeDIO.resourceCosts[view.targetLevel],view.buildingTypeDIO.upgradeDurationsPerLevel[view.targetLevel] / userInfo.serverSpeed))
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               return;
            }
         }
         if(city.numberOfWorkingWorkers >= city.numberOfWorkers)
         {
            view.addWindowEnumeration(new WindowEnumeration(47,{
               "type":view.type,
               "buildingInfo":view.buildingInfo,
               "buildingDIO":view.buildingTypeDIO,
               "windowEnumerations":view.windowEnumerations
            }));
            view.addWindowEnumeration(new WindowEnumeration(27,{}));
            closeWindow();
            return;
         }
         if(!param1 && param2 > 0)
         {
            _loc4_ = new UpgradeBuildingRequest(view.buildingInfo.instanceId,false,true);
            view.addWindowEnumeration(new WindowEnumeration(47,{
               "type":view.type,
               "buildingInfo":view.buildingInfo,
               "buildingDIO":view.buildingTypeDIO,
               "windowEnumerations":view.windowEnumerations
            }));
            view.addWindowEnumeration(new WindowEnumeration(43,{
               "type":"upgrade",
               "missingResourcesArray":param3,
               "outgoingMessage":_loc4_
            }));
            closeWindow();
            return;
         }
         closeWindow();
         eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new UpgradeBuildingRequest(view.buildingInfo.instanceId,param1)));
         if(param1)
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
         }
         else
         {
            soundPlayer.playSfxById("UseResources");
         }
      }
      
      private function updateWindow() : void
      {
         view.updateWithResources(city.resourceAmounts);
      }
   }
}

