package wom.view.mediator.screen.popups.apologies
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   
   public class MobileActionNotPossiblePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileActionNotPossiblePopup;
      
      public function MobileActionNotPossiblePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onOkButtonClicked,Event);
      }
      
      protected function onOkButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

