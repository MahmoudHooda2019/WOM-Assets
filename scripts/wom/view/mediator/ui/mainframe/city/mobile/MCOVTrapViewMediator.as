package wom.view.mediator.ui.mainframe.city.mobile
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.building.BuildingInfo;
   import wom.view.screen.windows.build.MobileRearmTrapsWindow;
   import wom.view.screen.windows.recycle.MobileRecycleTrapWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVTrapView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipWithOneProgressInfoView;
   
   public class MCOVTrapViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var trapView:MCOVTrapView;
      
      public function MCOVTrapViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(trapView.rearmButton,"triggered",onRearmButtonClicked);
         eventMap.mapStarlingListener(trapView.sellButton,"triggered",onSellButtonClicked);
      }
      
      private function onSellButtonClicked() : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRecycleTrapWindow(trapView.buildingInfo)));
      }
      
      private function onRearmButtonClicked(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 39 && _loc2_.healthPoint == 0)
            {
               _loc3_++;
            }
            else if(_loc2_.buildingTypeId == 40 && _loc2_.healthPoint == 0)
            {
               _loc4_++;
            }
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRearmTrapsWindow(domainInfo.getBuilding(40),domainInfo.getBuilding(39),_loc4_,_loc3_)));
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         trapView.addInfoView(new MobileBuildingTooltipWithOneProgressInfoView(0,buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGE.id]));
      }
   }
}

