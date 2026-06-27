package wom.view.mediator.screen.windows.gold
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.model.mobile.MobileAlertDialog;
   import wom.service.mobile.MobileInAppPurchaseService;
   import wom.view.screen.windows.gold.MobileGetGoldProductView;
   
   public class MobileGetGoldProductViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileGetGoldProductView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var mobileInAppPurchaseService:MobileInAppPurchaseService;
      
      public function MobileGetGoldProductViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.buyButton,"triggered",onGoldProductSelected,Event);
      }
      
      private function onGoldProductSelected(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(!mobileInAppPurchaseService.setupSuccessful)
         {
            var _temp_7:* = §§findproperty(MobileAlertDialogsEvent);
            var _temp_6:* = "showMobileAlertDialog";
            var _temp_5:* = §§findproperty(MobileAlertDialog);
            var _temp_4:* = 1;
            var _temp_3:* = 1;
            var _loc3_:String = "m.ui.popups.inapppurchase.account.title";
            var _temp_2:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            var _loc4_:String = "m.ui.popups.inapppurchase.account.message";
            var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            var _loc5_:String = "m.ui.popups.inapppurchase.close";
            dispatch(new MobileAlertDialogsEvent(_temp_6,new MobileAlertDialog(_temp_4,_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc5_))));
         }
         else if(!mobileInAppPurchaseService.produtsLoadedSuccesfully)
         {
            mobileInAppPurchaseService.getProducts();
            var _temp_15:* = §§findproperty(MobileAlertDialogsEvent);
            var _temp_14:* = "showMobileAlertDialog";
            var _temp_13:* = §§findproperty(MobileAlertDialog);
            var _temp_12:* = 1;
            var _temp_11:* = 1;
            var _loc6_:String = "m.ui.popups.inapppurchase.load.title";
            var _temp_10:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            var _loc7_:String = "m.ui.popups.inapppurchase.load.message";
            var _temp_9:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            var _loc8_:String = "m.ui.popups.inapppurchase.close";
            dispatch(new MobileAlertDialogsEvent(_temp_14,new MobileAlertDialog(_temp_12,_temp_11,_temp_10,_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc8_))));
         }
         else if(view.goldProductDTO)
         {
            _loc2_ = {
               "productId":view.goldProductDTO.id,
               "amountOfGold":view.goldProductDTO.amountOfGold,
               "peakPayId":view.goldProductDTO.peakPayId
            };
            dispatch(new MobileInAppPurchaseEvent("preparePurchase",_loc2_));
         }
      }
   }
}

