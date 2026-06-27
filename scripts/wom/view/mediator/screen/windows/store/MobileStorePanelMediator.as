package wom.view.mediator.screen.windows.store
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.store.MobileStorePanel;
   
   public class MobileStorePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileStorePanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileStorePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         switch(view.tabBar.selectedIndex)
         {
            case 0:
               onConstructionTabClicked(param1);
               break;
            case 1:
               onResourceTabClicked(param1);
               break;
            case 2:
               onSpeedUpsTabClicked(param1);
               break;
            case 3:
               onCombatTabClicked(param1);
               break;
            case 4:
               onSpeedUpsOnlyBuildingsTabClicked(param1);
         }
      }
      
      private function onConstructionTabClicked(param1:Event) : void
      {
         view.activateConstructionTab();
      }
      
      private function onResourceTabClicked(param1:Event) : void
      {
         view.activateResourceTab();
      }
      
      private function onSpeedUpsTabClicked(param1:Event) : void
      {
         view.activateSpeedUpsTab();
      }
      
      private function onSpeedUpsOnlyBuildingsTabClicked(param1:Event) : void
      {
         view.activateSpeedUpsOnlyBuildingsTab();
      }
      
      private function onCombatTabClicked(param1:Event) : void
      {
         view.activateCombatTab();
      }
   }
}

