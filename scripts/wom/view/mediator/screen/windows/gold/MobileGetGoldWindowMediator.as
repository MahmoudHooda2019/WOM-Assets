package wom.view.mediator.screen.windows.gold
{
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   
   public class MobileGetGoldWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGetGoldWindow;
      
      public function MobileGetGoldWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("mobileProductsLoaded",onMobileProductsLoaded);
      }
      
      private function onMobileProductsLoaded(param1:MobileInAppPurchaseEvent) : void
      {
         view.drawLayout();
      }
   }
}

