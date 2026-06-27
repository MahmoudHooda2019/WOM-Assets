package wom.view.mediator.screen.popups.facebook
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.view.screen.popups.facebook.MobileFBConnectToSendGiftPanel;
   
   public class MobileFBConnectToSendGiftPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileFBConnectToSendGiftPanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileFBConnectToSendGiftPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.connectButton,"triggered",onConnectButtonClicked,Event);
      }
      
      private function onConnectButtonClicked() : void
      {
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
         dispatch(new MobileFacebookConnectionEvent("connectToFacebook"));
      }
   }
}

