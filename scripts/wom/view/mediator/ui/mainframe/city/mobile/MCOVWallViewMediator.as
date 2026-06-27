package wom.view.mediator.ui.mainframe.city.mobile
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVWallView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipWithOneProgressInfoView;
   
   public class MCOVWallViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var view:MCOVWallView;
      
      public function MCOVWallViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.upgradeAllButton,"triggered",onUpgradeAllButtonClicked,Event);
      }
      
      private function onUpgradeAllButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow()));
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         view.addInfoView(new MobileBuildingTooltipWithOneProgressInfoView(1,buildingTypeDIO.healthPointsPerLevel[buildingInfo.level == 0 ? 0 : buildingInfo.level - 1],true));
      }
   }
}

