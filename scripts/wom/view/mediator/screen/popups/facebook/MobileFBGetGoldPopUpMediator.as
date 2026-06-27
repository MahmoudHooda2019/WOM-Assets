package wom.view.mediator.screen.popups.facebook
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileGuestNamingPopUp;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   
   public class MobileFBGetGoldPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFBGetGoldPopUp;
      
      public function MobileFBGetGoldPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onActionButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onActionButtonClicked(param1:Event) : void
      {
         view.closeWithActionButton = true;
         closeWindow();
         eventDispatcher.addEventListener("connectionCancelled",onFacebookConnectionCanceled);
         dispatch(new MobileFacebookConnectionEvent("connectToFacebook"));
      }
      
      private function onFacebookConnectionCanceled(param1:MobileFacebookConnectionEvent) : void
      {
         eventDispatcher.removeEventListener("connectionCancelled",onFacebookConnectionCanceled);
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileGuestNamingPopUp()));
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view));
         if(!view.closeWithActionButton && view.mandatory)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileGuestNamingPopUp()));
         }
      }
   }
}

