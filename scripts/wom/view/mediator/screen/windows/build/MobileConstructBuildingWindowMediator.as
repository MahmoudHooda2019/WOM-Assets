package wom.view.mediator.screen.windows.build
{
   import flash.geom.Point;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.build.MobileConstructBuildingWindow;
   
   public class MobileConstructBuildingWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileConstructBuildingWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileConstructBuildingWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.serverSpeed = userInfo.serverSpeed;
         super.onRegister();
         eventMap.mapStarlingListener(view.buildWithResourcesButton,"triggered",onBuildWithResourcesClicked,Event);
         eventMap.mapStarlingListener(view.buildWithGoldButton,"triggered",onBuildWithGoldClicked,Event);
         addContextListener("resourcesUpdated",onResourcesUpdated,ModelUpdateEvent);
         addContextListener("buildingTypesUpdated",onBuildingTypesUpdated,ModelUpdateEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         onResourcesUpdated(null);
         onBuildingTypesUpdated(null);
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.buildWithResourcesButton.localToGlobal(new Point()),param1.additionalInfo,view.buildWithResourcesButton));
      }
      
      private function onBuildingTypesUpdated(param1:Event) : void
      {
         view.updatePrerequisitesData(city.buildings);
      }
      
      private function onResourcesUpdated(param1:Event) : void
      {
         view.updateWithResources(city.resourceAmounts);
      }
      
      private function onBuildWithGoldClicked(param1:Event) : void
      {
         if(!isFacebookRequirementsSatisfied())
         {
            closeWindow();
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
         }
         else if(!view.requirementsSatisfied)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "m.ui.warning.requirementsnotmet";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         else if(userInfo.numberOfGolds < StoreUtil.buildingPriceWithRequirementsVector(view.buildingTypeDIO.resourceCosts[0],view.buildingTypeDIO.upgradeDurationsPerLevel[0]))
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else
         {
            build(true);
         }
      }
      
      private function onBuildWithResourcesClicked(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(!isFacebookRequirementsSatisfied())
         {
            closeWindow();
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
         }
         else if(!view.requirementsSatisfied)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc9_:String = "m.ui.warning.requirementsnotmet";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc9_)));
         }
         else if(view.resourcesSatisfied)
         {
            build(false);
         }
         else
         {
            _loc5_ = 0;
            _loc3_ = [];
            for each(var _loc2_ in view.buildingTypeDIO.resourceCosts[0])
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
            build(false,_loc4_,_loc3_);
         }
      }
      
      private function build(param1:Boolean, param2:int = 0, param3:Array = null) : void
      {
         if(city.numberOfWorkingWorkers >= city.numberOfWorkers)
         {
            view.addWindowEnumeration(new WindowEnumeration(30,{
               "buildingTypeInfo":view.buildingTypeInfo,
               "buildingTypeDIO":view.buildingTypeDIO,
               "windowEnumerations":view.windowEnumerations
            }));
            view.addWindowEnumeration(new WindowEnumeration(27,{}));
            closeWindow();
            return;
         }
         if(!param1 && param2 > 0)
         {
            view.addWindowEnumeration(new WindowEnumeration(30,{
               "buildingTypeInfo":view.buildingTypeInfo,
               "buildingTypeDIO":view.buildingTypeDIO,
               "windowEnumerations":view.windowEnumerations
            }));
            view.addWindowEnumeration(new WindowEnumeration(44,{
               "buildingTypeId":view.buildingTypeDIO.id,
               "missingResourcesArray":param3
            }));
            closeWindow();
            return;
         }
         if(view.windowEnumerations)
         {
            view.windowEnumerations.length = 0;
         }
         closeWindow();
         dispatch(new ActionSelectEvent("actionSelect",ActionType.BUILD));
         coreManager.startBuild(view.buildingTypeDIO.id,param1,param2 > 0,userInfo.mandatoryTutorialCompleted);
      }
      
      private function isFacebookRequirementsSatisfied() : Boolean
      {
         return !(view.buildingTypeInfo.constructTypeId == 38 && !mobileConnectionServiceInfo.isConnectedWithFacebook());
      }
   }
}

