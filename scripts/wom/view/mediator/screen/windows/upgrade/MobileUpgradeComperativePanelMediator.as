package wom.view.mediator.screen.windows.upgrade
{
   import starling.events.Event;
   import wom.controller.event.model.GoToWindowEvent;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.upgrade.MobileUpgradeComperativePanel;
   
   public class MobileUpgradeComperativePanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileUpgradeComperativePanel;
      
      public function MobileUpgradeComperativePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.upgradeAllWallsButton,"triggered",onUpgradeAllWallsButtonClicked,Event);
      }
      
      private function onUpgradeAllWallsButtonClicked(param1:Event) : void
      {
         dispatch(new GoToWindowEvent("gotostore"));
      }
   }
}

