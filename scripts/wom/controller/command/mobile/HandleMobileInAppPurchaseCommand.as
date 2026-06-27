package wom.controller.command.mobile
{
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.service.mobile.MobileInAppPurchaseService;
   
   public class HandleMobileInAppPurchaseCommand extends PCommand
   {
      
      [Inject]
      public var event:MobileInAppPurchaseEvent;
      
      [Inject]
      public var mobileInAppPurchaseService:MobileInAppPurchaseService;
      
      public function HandleMobileInAppPurchaseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         switch(event.type)
         {
            case "setupMobileInAppPurchaseService":
               mobileInAppPurchaseService.init();
               break;
            case "retreiveProductsFromStore":
               mobileInAppPurchaseService.getProducts();
               break;
            case "preparePurchase":
               mobileInAppPurchaseService.preparePurchase(event.data.productId,event.data.amountOfGold,"peakPayId" in event.data ? event.data.peakPayId : null);
               break;
            case "makePurchase":
               mobileInAppPurchaseService.makePurchase(event.data.productId);
               break;
            case "consumePurchase":
               mobileInAppPurchaseService.consumePurchase(event.data.purchase);
         }
      }
   }
}

