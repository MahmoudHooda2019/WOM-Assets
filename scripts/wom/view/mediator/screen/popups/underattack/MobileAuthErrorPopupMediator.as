package wom.view.mediator.screen.popups.underattack
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileAuthErrorPopup;
   
   public class MobileAuthErrorPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAuthErrorPopup;
      
      public function MobileAuthErrorPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onRetryButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onRetryButtonClicked(param1:Event) : void
      {
         dispatch(new MobileApplicationEvent("restartMobileApplication"));
      }
      
      override protected function closeWindow() : void
      {
      }
   }
}

