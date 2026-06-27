package wom.view.mediator.screen.popups.facebook
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.facebook.MobileFBConfirmationPopUp;
   
   public class MobileFBConfirmationPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFBConfirmationPopUp;
      
      public function MobileFBConfirmationPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.negativeButton,"triggered",onNegativeButtonClicked,Event);
         eventMap.mapStarlingListener(view.positiveButton,"triggered",onPositiveButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onPositiveButtonClicked() : void
      {
         closeWindow();
         dispatch(new MobileExternalInterfaceEvent("notifyChooseAccount",{"isWebSelected":view.isWebSelected}));
      }
      
      private function onNegativeButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileFacebookConnectionEvent("connectionCancelled"));
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view));
      }
   }
}

