package wom.view.mediator.screen.popups.peakpay
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.service.mobile.MobileInAppPurchaseService;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.peakpay.MobileChoosePaymentProviderPopUp;
   import wom.view.screen.windows.MobileWebViewWindow;
   
   public class MobileChoosePaymentProviderPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileChoosePaymentProviderPopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileChoosePaymentProviderPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.peakPayButton,"triggered",onPeakPayButtonClicked,Event);
         eventMap.mapStarlingListener(view.googleWalletButton,"triggered",onGoogleWalletButtonClicked,Event);
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
      
      private function onPeakPayButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobilePopUpWindowEvent("closeTopPopUpWindow",null));
         var _loc2_:String = MobileInAppPurchaseService.getPeakPayUrl(userInfo.profile.gameId,view.peakPayId);
         var _temp_3:* = §§findproperty(MobilePopUpWindowEvent);
         var _temp_2:* = "showPopUpWindow";
         var _temp_1:* = §§findproperty(MobileWebViewWindow);
         var _loc3_:String = "ui.windows.gold.header";
         dispatch(new MobilePopUpWindowEvent(_temp_2,new MobileWebViewWindow(peak.i18n.PText.INSTANCE.getText0(_loc3_),_loc2_)));
      }
      
      private function onGoogleWalletButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileInAppPurchaseEvent("makePurchase",{"productId":view.productId}));
      }
   }
}

