package wom.view.mediator.ui.mainframe.city.mobile
{
   import flash.geom.Point;
   import starling.events.Event;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.view.screen.windows.fortify.MobileFortifyWindow;
   import wom.view.screen.windows.upgrade.MobileUpgradeWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVIdleView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProductionProgressInfoView;
   
   public class MCOVIdleViewMediator extends MobileConstructableOptionsViewMediator
   {
      
      [Inject]
      public var upgradeView:MCOVIdleView;
      
      public function MCOVIdleViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         determineButtonStatus();
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         eventMap.mapStarlingListener(upgradeView.upgradeButton,"triggered",onUpgradeClicked);
         eventMap.mapStarlingListener(upgradeView.fortifyButton,"triggered",onFortifyClicked);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,upgradeView.upgradeButton.localToGlobal(new Point()),param1.additionalInfo,upgradeView.upgradeButton));
      }
      
      private function onUpgradeClicked(param1:Event) : void
      {
         cancelSelection();
         if(buildingTypeDIO.id == 10)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileUpgradeWindow(3,buildingInfo,buildingTypeDIO)));
         }
         else if(buildingTypeDIO.id == 23 || buildingTypeDIO.id == 27 || buildingTypeDIO.id == 17 || buildingTypeDIO.id == 18)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileUpgradeWindow(1,buildingInfo,buildingTypeDIO)));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileUpgradeWindow(2,buildingInfo,buildingTypeDIO)));
         }
      }
      
      private function onFortifyClicked(param1:Event) : void
      {
         cancelSelection();
         eventDispatcher.dispatchEvent(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFortifyWindow(buildingInfo,buildingTypeDIO)));
      }
      
      protected function determineButtonStatus() : void
      {
         var _loc1_:Boolean = buildingTypeDIO.maxLevels > 1 && buildingInfo.level < buildingTypeDIO.maxLevels;
         var _loc2_:Boolean = BuildingSpecificInfoType.FORTIFICATION_INFO.id in buildingTypeDIO.buildingSpecificInfo && buildingInfo.fortificationLevel < (buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO).maxLevels;
         upgradeView.determineButtonStatus(_loc1_,_loc2_);
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         if(buildingInfo.buildingTypeId == 10)
         {
            upgradeView.addInfoView(new MobileBuildingTooltipProductionProgressInfoView("IconGoldS",buildingInfo,buildingTypeDIO));
         }
      }
   }
}

