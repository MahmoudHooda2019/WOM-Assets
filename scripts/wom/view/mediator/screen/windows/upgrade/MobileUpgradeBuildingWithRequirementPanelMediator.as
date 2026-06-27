package wom.view.mediator.screen.windows.upgrade
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.CityStatusInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.upgrade.MobileUpgradeBuildingWithRequirementPanel;
   
   public class MobileUpgradeBuildingWithRequirementPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileUpgradeBuildingWithRequirementPanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileUpgradeBuildingWithRequirementPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("buildingTypesUpdated",onBuildingTypesUpdated,ModelUpdateEvent);
         onBuildingTypesUpdated(null);
      }
      
      private function onBuildingTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.updatePrerequisitesData(city.buildings);
      }
   }
}

