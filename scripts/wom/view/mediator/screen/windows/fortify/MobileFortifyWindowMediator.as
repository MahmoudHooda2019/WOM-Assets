package wom.view.mediator.screen.windows.fortify
{
   import peak.i18n.PText;
   import peak.messaging.OutgoingMessage;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.FortifyBuildingRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.fortify.MobileFortifyWindow;
   
   public class MobileFortifyWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFortifyWindow;
      
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
      
      public function MobileFortifyWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.serverSpeed = userInfo.serverSpeed;
         super.onRegister();
         eventMap.mapStarlingListener(view.upgradeWithResourcesButton,"triggered",onUpgradeWithResourcesClicked,Event);
         eventMap.mapStarlingListener(view.upgradeWithGoldButton,"triggered",onUpgradeWithGoldClicked,Event);
         addContextListener("resourcesUpdated",updateWindow,ModelUpdateEvent);
         addContextListener("buildingTypesUpdated",onBuildingTypesUpdated,ModelUpdateEvent);
         updateWindow(null);
         onBuildingTypesUpdated(null);
      }
      
      private function onUpgradeWithGoldClicked(param1:Event) : void
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
            fortifyBuilding(true);
         }
      }
      
      private function onUpgradeWithResourcesClicked(param1:Event) : void
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
         }
         else if(view.resourcesSatisfied)
         {
            fortifyBuilding();
         }
         else
         {
            _loc5_ = 0;
            _loc3_ = [];
            for each(var _loc2_ in view.fortificationInfoDIO.resourceCosts[view.targetLevelIndex])
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
            fortifyBuilding(false,_loc4_,_loc3_);
         }
      }
      
      private function fortifyBuilding(param1:Boolean = false, param2:int = 0, param3:Array = null) : void
      {
         var _loc4_:OutgoingMessage = null;
         if(param1)
         {
            if(userInfo.numberOfGolds < StoreUtil.buildingPriceWithRequirementsVector(view.fortificationInfoDIO.resourceCosts[view.targetLevelIndex],view.fortificationInfoDIO.fortifyDurationsPerLevelInSecs[view.targetLevelIndex]))
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               return;
            }
         }
         if(city.numberOfWorkingWorkers >= city.numberOfWorkers)
         {
            view.addWindowEnumeration(new WindowEnumeration(48,{
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
            _loc4_ = new FortifyBuildingRequest(view.buildingInfo.instanceId,false,true);
            view.addWindowEnumeration(new WindowEnumeration(48,{
               "buildingInfo":view.buildingInfo,
               "buildingDIO":view.buildingTypeDIO,
               "windowEnumerations":view.windowEnumerations
            }));
            view.addWindowEnumeration(new WindowEnumeration(43,{
               "type":"fortify",
               "missingResourcesArray":param3,
               "outgoingMessage":_loc4_
            }));
            closeWindow();
            return;
         }
         if(param1)
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
         }
         else
         {
            soundPlayer.playSfxById("UseResources");
         }
         closeWindow();
         eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new FortifyBuildingRequest(view.buildingInfo.instanceId,param1)));
      }
      
      private function updateWindow(param1:ModelUpdateEvent) : void
      {
         view.updateWithResources(city.resourceAmounts);
      }
      
      private function onBuildingTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.updatePrerequisitesData(city.buildings);
      }
   }
}

