package wom.view.mediator.screen.windows.store
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.gold.PaymentInfo;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   import wom.view.screen.windows.store.MobileStoreWindow;
   
   public class MobileStoreWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileStoreWindow;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      public function MobileStoreWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.addGoldButton,"triggered",onAddGoldButtonClicked,Event);
      }
      
      private function onAddGoldButtonClicked() : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileGetGoldWindow(paymentInfo.goldProducts,MonetizationType.ADD_GOLD,paymentInfo.getMobileGoldProductsLength() > 0,paymentInfo.topSellerGoldProductId,null,null)));
         closeWindow();
      }
   }
}

