package wom.view.mediator.screen.windows.beast.cave
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.BuildingUpgradeCompletedEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.WomBeastCaveTabBar;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.beast.cave.MobileBeastCaveWindow;
   
   public class MobileBeastCaveWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBeastCaveWindow;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBeastCaveWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateBeast();
         view.activateTabByIndex(view.initialTabIndex);
         addContextListener("beastUpdated",onBeastUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
         eventMap.mapStarlingListener(view.tabBar,"showSecondaryPopUpWindow",onShowSecondaryPopUpWindow,PopUpWindowEvent);
      }
      
      private function onShowSecondaryPopUpWindow(param1:MobilePopUpWindowEvent) : void
      {
         dispatch(param1);
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         if(view.tabBar.selectedIndex != -1)
         {
            updateBeast();
            view.activateTabByIndex(view.tabBar.selectedIndex);
         }
      }
      
      private function updateBeast() : void
      {
         view.updateTabs(city.beast,city.beast != null ? domainInfo.getBeast(city.beast.typeId) : null);
      }
      
      private function onBeastUpdated(param1:ModelUpdateEvent) : void
      {
         updateBeast();
      }
      
      private function getBeastKeeperStatus() : int
      {
         var _loc2_:BuildingTypeDIO = null;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 30)
            {
               _loc2_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
               if(!_loc2_.isHealthy(_loc1_.level,_loc1_.healthPoint))
               {
                  return 2;
               }
               return 0;
            }
         }
         return 1;
      }
      
      private function buildingUpgradeCompleted() : void
      {
         (view.tabBar as WomBeastCaveTabBar).beastKeeperExist = getBeastKeeperStatus();
      }
      
      private function onBuildingUpgradeCompleted(param1:BuildingUpgradeCompletedEvent) : void
      {
         buildingUpgradeCompleted();
      }
   }
}

