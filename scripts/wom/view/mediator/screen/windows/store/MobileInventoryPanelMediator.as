package wom.view.mediator.screen.windows.store
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.store.MobileInventoryPanel;
   
   public class MobileInventoryPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileInventoryPanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileInventoryPanelMediator()
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
               onAllTabClicked(param1);
               break;
            case 1:
               onResourceTabClicked(param1);
               break;
            case 2:
               onPartsTabClicked(param1);
               break;
            case 3:
               onTavernTabClicked(param1);
         }
      }
      
      private function onAllTabClicked(param1:Event) : void
      {
         view.activateAllTab();
      }
      
      private function onResourceTabClicked(param1:Event) : void
      {
         view.activateResourceTab();
      }
      
      private function onPartsTabClicked(param1:Event) : void
      {
         view.activatePartsTab();
      }
      
      private function onTavernTabClicked(param1:Event) : void
      {
         view.activateTavernTab();
      }
   }
}

