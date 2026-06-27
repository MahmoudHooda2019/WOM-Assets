package wom.view.mediator.ui.mainframe
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.CityPlannerEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.component.attribute.data.PlannerBuildingData;
   import wom.model.component.attribute.data.PlannerConstructableData;
   import wom.model.component.attribute.data.PlannerDecorationData;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   import wom.model.game.WomScreenType;
   import wom.model.game.window.MobileWindowEnumerationButton;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.ApplyCityPlanRequest;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.windows.MobileCityPlannerSaveWindow;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerLoadWindow;
   import wom.view.ui.mainframe.city.MobileCityPlannerUILayer;
   
   public class MobileCityPlannerUILayerMediator extends MobileUILayerMediator
   {
      
      [Inject]
      public var view:MobileCityPlannerUILayer;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      public function MobileCityPlannerUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.closeButton,"triggered",onCloseButtonClicked,Event);
         eventMap.mapStarlingListener(view.saveButton,"triggered",onSaveButtonClicked,Event);
         eventMap.mapStarlingListener(view.loadButton,"triggered",onLoadButtonClicked,Event);
         eventMap.mapStarlingListener(view.applyButton,"triggered",onApplyButtonClicked,Event);
         eventMap.mapStarlingListener(view.sellButton,"triggered",onSellButtonClicked,Event);
         eventMap.mapStarlingListener(view.archerButton,"change",onArcherButtonToggle,Event);
         eventMap.mapStarlingListener(view.cannonButton,"change",onCannonButtonToggle,Event);
         eventMap.mapStarlingListener(view.gatlingButton,"change",onGatlingButtonToggle,Event);
         eventMap.mapStarlingListener(view.flamerButton,"change",onFlamerButtonToggle,Event);
         eventMap.mapStarlingListener(view.skyButton,"change",onSkyButtonToggle,Event);
         eventMap.mapStarlingListener(view.mirrorButton,"change",onMirrorButtonToggle,Event);
         eventMap.mapStarlingListener(view.watchPostButton,"change",onWatchPostButtonToggle,Event);
         eventMap.mapStarlingListener(view.beastButton,"change",onBeastButtonToggle,Event);
         eventMap.mapStarlingListener(view.beastCannonButton,"change",onBeastCannonButtonToggle,Event);
         eventMap.mapStarlingListener(view.toggleGridsButton,"triggered",onGridSwitchButtonClicked,Event);
         eventMap.mapStarlingListener(view.clearLayoutButton,"triggered",onClearLayoutButtonClicked,Event);
         addContextListener("saveLayout",onExitPopupSave,CityPlannerEvent);
         addContextListener("discardLayout",onExitPopupDiscard,CityPlannerEvent);
         addContextListener("saveLayoutSuccess",onSaveLayoutDiscard,CityPlannerEvent);
         addContextListener("resetSelections",onResetSelections,CityPlannerEvent);
         addContextListener("cityDimensionsUpdated",onCityDimensionsUpdated,ModelUpdateEvent);
         plannerRoot.inspectedBuildingChanged.addFunction(onInspectedBuildingChanged);
      }
      
      private function onSellButtonClicked(param1:Event) : void
      {
         var _loc2_:Vector.<MobileWindowEnumerationButton> = new Vector.<MobileWindowEnumerationButton>();
         var _loc4_:Object = {
            "buildingInfo":(plannerRoot.inspectedBuilding.data as PlannerBuildingData).buildingData.buildingInfo,
            "buildingTypeDIO":(plannerRoot.inspectedBuilding.data as PlannerBuildingData).buildingData.buildingTypeDIO
         };
         var _loc3_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _loc3_.width = 200;
         var _temp_1:* = _loc3_;
         var _loc6_:String = "ui.windows.alliance.myalliance.confirm";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         var _loc5_:MobileWindowEnumerationButton = new MobileWindowEnumerationButton(new WindowEnumeration(208,_loc4_),_loc3_);
         _loc2_.push(_loc5_);
         var _temp_7:* = §§findproperty(MobilePopUpWindowEvent);
         var _temp_6:* = "showSecondaryPopUpWindow";
         var _temp_5:* = §§findproperty(MobileClementineChangableActionPopUp);
         var _temp_4:* = 1;
         var _loc7_:String = "ui.windows.cityplanner.areyousure";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _temp_2:* = "m.ui.popups.sellbuildingconfirmation.desc";
         var _loc8_:String = "domain.building." + (plannerRoot.inspectedBuilding.data as PlannerBuildingData).buildingData.buildingTypeDIO.id + ".name";
         var _loc9_:* = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc10_:String = _temp_2;
         dispatch(new MobilePopUpWindowEvent(_temp_6,new MobileClementineChangableActionPopUp(_temp_4,_temp_3,peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_),_loc2_)));
      }
      
      private function onInspectedBuildingChanged() : void
      {
         var _loc1_:PlannerConstructableData = null;
         var _loc3_:PlannerDecorationData = null;
         var _loc2_:PlannerBuilding = plannerRoot.inspectedBuilding;
         if(_loc2_)
         {
            _loc1_ = _loc2_.data;
            if(_loc1_ is PlannerDecorationData)
            {
               _loc3_ = _loc1_ as PlannerDecorationData;
               var _temp_1:* = view.constructableNameTF;
               var _loc4_:String = "domain.decoration." + _loc3_.decoration.data.dio.id + (_loc3_.decoration.data.info.subType ? "." + _loc3_.decoration.data.info.subType : "") + ".name";
               _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            }
            else
            {
               var _temp_2:* = view.constructableNameTF;
               var _loc5_:String = "domain.building." + (_loc1_ as PlannerBuildingData).buildingData.buildingTypeDIO.id + ".name";
               _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            }
            view.constructableMenuContainer.visible = true;
         }
         else
         {
            view.constructableNameTF.text = "";
            view.constructableMenuContainer.visible = false;
         }
      }
      
      private function onCityDimensionsUpdated(param1:ModelUpdateEvent) : void
      {
         plannerRoot.updateDimensions();
      }
      
      private function onExitPopupDiscard(param1:CityPlannerEvent) : void
      {
         returnToCity();
      }
      
      private function onExitPopupSave(param1:CityPlannerEvent) : void
      {
         saveButtonClickAction();
      }
      
      public function saveButtonClickAction() : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCityPlannerSaveWindow()));
      }
      
      private function onResetSelections(param1:CityPlannerEvent) : void
      {
         view.resetSelections();
      }
      
      private function onSaveLayoutDiscard(param1:CityPlannerEvent) : void
      {
         plannerRoot.refreshBuildingsStartPoint();
      }
      
      public function returnToCity() : void
      {
         plannerRoot.terminate();
         dispatch(new ActivateScreenEvent("activate",WomScreenType.CITY));
      }
      
      private function onClearLayoutButtonClicked(param1:Event) : void
      {
         plannerRoot.clearCityLayout();
      }
      
      private function onGridSwitchButtonClicked(param1:Event) : void
      {
         plannerRoot.toggleGrids(view.toggleGridsButton.isSelected);
      }
      
      private function onApplyButtonClicked(param1:Event) : void
      {
         var _loc2_:Boolean = plannerRoot.isLayoutValid();
         if(!_loc2_)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc3_:String = "ui.windows.cityplanner.cantapplyinvalidlayout";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc3_)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ApplyCityPlanRequest(plannerRoot.getPlannerSnapShot(true))));
            returnToCity();
         }
      }
      
      private function onLoadButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCityPlannerLoadWindow()));
      }
      
      private function onSaveButtonClicked(param1:Event) : void
      {
         saveButtonClickAction();
      }
      
      private function onCloseButtonClicked(param1:Event) : void
      {
         returnToCity();
      }
      
      private function onArcherButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleArcherRanges(view.archerButton.isSelected);
      }
      
      private function onBeastCannonButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleBeastCannonRanges(view.beastCannonButton.isSelected);
      }
      
      private function onCannonButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleCannonRanges(view.cannonButton.isSelected);
      }
      
      private function onGatlingButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleGatlingRanges(view.gatlingButton.isSelected);
      }
      
      private function onFlamerButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleFlamerRanges(view.flamerButton.isSelected);
      }
      
      private function onSkyButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleSkyRanges(view.skyButton.isSelected);
      }
      
      private function onMirrorButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleMirrorRanges(view.mirrorButton.isSelected);
      }
      
      private function onWatchPostButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleWatchPostRanges(view.watchPostButton.isSelected);
      }
      
      private function onBeastButtonToggle(param1:Event) : void
      {
         plannerRoot.toggleBeastRanges(view.beastButton.isSelected);
      }
   }
}

