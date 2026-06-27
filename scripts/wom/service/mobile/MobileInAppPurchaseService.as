package wom.service.mobile
{
   import com.adobe.crypto.MD5;
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Product;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.events.InAppBillingEvent;
   import com.freshplanet.ane.AirDeviceId;
   import org.robotlegs.mvcs.Actor;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.dto.gold.GoldProductDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.PaymentInfo;
   import wom.model.mobile.MobileAlertDialog;
   import wom.view.screen.popups.peakpay.MobileChoosePaymentProviderPopUp;
   
   public class MobileInAppPurchaseService extends Actor
   {
      
      private static const TAG:String = "ANE-SERVICE";
      
      private static const DEV_KEY:String = "284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==";
      
      private static const GOOGLE_PLAY_INAPP_BILLING_KEY:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh1aEggMhS7s75RVirC4eQVhkRZ5jx2XGgMHFycJTMyg8pNw38XFnw9Sa5Rpypxz2tFLWQGdrnMqF3zT2lx4WTw77Jz7CIyof+L5LiDNAJEOHDgXBCMNP1Jzmi2i2kLt0R865FRVS0nKOVnXxFLy4qD1WwoUzIQtZvqBtiNXLizMURFwVm2TiyOFjfNJoiMH8eghkFbb7fvsk1YsbCToCLtB2YlNrSKjS2nwPHBYW3FLlUiGmQX4rhFHisA9dc7yEraLo5G8PlprDTr0w2dtBe8DCc8EOBKF/v1gXptGn1es/HVQk07xctK22UJJ213D8HtLFWbRKaJyBIIB1wfJ5swIDAQAB";
      
      private static const APPLE_STORE_INAPP_BILLING_KEY:String = "48b45a74f4c14b9d9e528360db8e5061";
      
      public static var PEAKPAY_BASE_URL:String = "http://npay.peakgames.net/index.php/payment";
      
      public static var PEAKPAY_APP_ID:String = "1067";
      
      public static var PEAKPAY_APP_TOKEN:String = "d3640aa98d03b91c780274c4615b6707";
      
      private static var INITIALIZED:Boolean = false;
      
      private static var INSTANCE:MobileInAppPurchaseService;
      
      private static var _produtsLoadedSuccesfully:Boolean = false;
      
      private static var _setupSuccessful:Boolean = false;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var mobileApplicationStatusManager:MobileApplicationStatusManager;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      private var consumeList:Array = [];
      
      private var consuming:Boolean = false;
      
      public function MobileInAppPurchaseService()
      {
         super();
      }
      
      public static function getPeakPayUrl(param1:String, param2:String) : String
      {
         var _loc3_:String = MD5.hash(PEAKPAY_APP_TOKEN + PEAKPAY_APP_ID + param1 + param2);
         return PEAKPAY_BASE_URL + "?appId=" + PEAKPAY_APP_ID + "&uid=" + param1 + "&productListId=" + param2 + "&token=" + _loc3_ + "&_lang=" + Languages.activeLanguageId;
      }
      
      public function init() : void
      {
         if(INITIALIZED)
         {
            InAppBilling.service.removeEventListener("setup:success",onSetupSuccess);
            InAppBilling.service.removeEventListener("setup:failure",onSetupFailed);
            InAppBilling.service.removeEventListener("products:loaded",onProductsLoaded);
            InAppBilling.service.removeEventListener("products:failed",onProductsFailed);
            InAppBilling.service.removeEventListener("product:invalid",onInvalidProduct);
            InAppBilling.service.removeEventListener("purchase:cancelled",onPurchaseCancelled);
            InAppBilling.service.removeEventListener("purchase:failed",onPurchaseFailed);
            InAppBilling.service.removeEventListener("purchase:success",onPurchaseSuccess);
            InAppBilling.service.removeEventListener("restore:purchases:success",onRestorePurchaseSuccess);
            InAppBilling.service.removeEventListener("restore:purchases:failed",onRestorePurchaseFailed);
            InAppBilling.service.removeEventListener("consume:success",onConsumeSuccess);
            InAppBilling.service.removeEventListener("consume:failed",onConsumeFailed);
            InAppBilling.service.dispose();
         }
         else
         {
            InAppBilling.init("284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==");
         }
         INITIALIZED = true;
         INSTANCE = this;
         InAppBilling.service.addEventListener("setup:success",onSetupSuccess);
         InAppBilling.service.addEventListener("setup:failure",onSetupFailed);
         InAppBilling.service.addEventListener("products:loaded",onProductsLoaded);
         InAppBilling.service.addEventListener("products:failed",onProductsFailed);
         InAppBilling.service.addEventListener("product:invalid",onInvalidProduct);
         InAppBilling.service.addEventListener("purchase:cancelled",onPurchaseCancelled);
         InAppBilling.service.addEventListener("purchase:failed",onPurchaseFailed);
         InAppBilling.service.addEventListener("purchase:success",onPurchaseSuccess);
         InAppBilling.service.addEventListener("restore:purchases:success",onRestorePurchaseSuccess);
         InAppBilling.service.addEventListener("restore:purchases:failed",onRestorePurchaseFailed);
         InAppBilling.service.addEventListener("consume:success",onConsumeSuccess);
         InAppBilling.service.addEventListener("consume:failed",onConsumeFailed);
         if(AirDeviceId.getInstance().isOnAndroid)
         {
            InAppBilling.service.setServiceType("google_play_inapp_billing");
            InAppBilling.service.setup("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh1aEggMhS7s75RVirC4eQVhkRZ5jx2XGgMHFycJTMyg8pNw38XFnw9Sa5Rpypxz2tFLWQGdrnMqF3zT2lx4WTw77Jz7CIyof+L5LiDNAJEOHDgXBCMNP1Jzmi2i2kLt0R865FRVS0nKOVnXxFLy4qD1WwoUzIQtZvqBtiNXLizMURFwVm2TiyOFjfNJoiMH8eghkFbb7fvsk1YsbCToCLtB2YlNrSKjS2nwPHBYW3FLlUiGmQX4rhFHisA9dc7yEraLo5G8PlprDTr0w2dtBe8DCc8EOBKF/v1gXptGn1es/HVQk07xctK22UJJ213D8HtLFWbRKaJyBIIB1wfJ5swIDAQAB");
         }
         else if(AirDeviceId.getInstance().isOnIOS)
         {
            InAppBilling.service.setServiceType("apple_inapp_purchase");
            InAppBilling.service.setup("48b45a74f4c14b9d9e528360db8e5061");
         }
      }
      
      public function makePurchase(param1:String) : void
      {
         if(AirDeviceId.getInstance().isOnIOS)
         {
            var _temp_6:* = §§findproperty(MobileAlertDialogsEvent);
            var _temp_5:* = "showMobileAlertDialog";
            var _temp_4:* = §§findproperty(MobileAlertDialog);
            var _temp_3:* = 2;
            var _temp_2:* = 3;
            var _loc2_:String = "m.ui.popups.loading.paymenttitle";
            var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            var _loc3_:String = "m.ui.popups.loading.paymentmessage";
            dispatch(new MobileAlertDialogsEvent(_temp_5,new MobileAlertDialog(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,null,false)));
         }
         mobileApplicationStatusManager.autoReload = false;
         mobileApplicationStatusManager.idleTimeoutDuration = 2;
         InAppBilling.service.makePurchase(new Purchase(param1));
      }
      
      public function preparePurchase(param1:String, param2:int, param3:String = null) : void
      {
         if(Boolean(AirDeviceId.getInstance().isOnAndroid) && Languages.activeLanguageId == "tr" && documentConfiguration.peakPayEnabled && param3 != null)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileChoosePaymentProviderPopUp(param1,param2,param3)));
            return;
         }
         makePurchase(param1);
      }
      
      public function getProducts() : void
      {
         trace("ANE-SERVICE","Get Products");
         var _loc2_:Array = [];
         for each(var _loc1_ in paymentInfo.goldProducts)
         {
            _loc2_.push(_loc1_.id);
         }
         if(userInfo.mobileSpecialOffer)
         {
            _loc2_.push(userInfo.mobileSpecialOffer.hashed_id);
         }
         InAppBilling.service.getProducts(_loc2_);
      }
      
      public function restorePurchases() : void
      {
         if(AirDeviceId.getInstance().isOnAndroid)
         {
            InAppBilling.service.restorePurchases();
         }
         else
         {
            dispatch(new MobileExternalInterfaceEvent("checkInAppBilling"));
         }
      }
      
      private function onSetupSuccess(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling setup success");
         _setupSuccessful = true;
      }
      
      private function onSetupFailed(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling setup FAILURE!",param1.data);
         _setupSuccessful = false;
      }
      
      private function onProductsLoaded(param1:InAppBillingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:GoldProductDTO = null;
         trace("ANE-SERVICE","InAppBilling products loaded");
         for each(var _loc2_ in param1.data)
         {
            _loc4_ = 0;
            while(_loc4_ < paymentInfo.goldProducts.length)
            {
               _loc3_ = paymentInfo.goldProducts[_loc4_];
               if(_loc3_.id == _loc2_.id)
               {
                  if(AirDeviceId.getInstance().isOnAndroid)
                  {
                     _loc3_.localPrice = _loc2_.price / 100;
                     _loc3_.localCurrency = _loc2_.currencySymbol;
                  }
                  else
                  {
                     _loc3_.localPrice = _loc2_.price;
                     _loc3_.localCurrency = _loc2_.currencySymbol;
                  }
                  break;
               }
               _loc4_++;
            }
            if(userInfo.mobileSpecialOffer && _loc2_.id == userInfo.mobileSpecialOffer.hashed_id)
            {
               if(AirDeviceId.getInstance().isOnAndroid)
               {
                  userInfo.mobileSpecialOffer.price = _loc2_.price / 100;
                  userInfo.mobileSpecialOffer.currencySymbol = _loc2_.currencySymbol;
               }
               else
               {
                  userInfo.mobileSpecialOffer.price = _loc2_.price;
                  userInfo.mobileSpecialOffer.currencySymbol = _loc2_.currencySymbol;
               }
               dispatch(new ModelUpdateEvent("mobileSpecialOfferUpdated"));
            }
         }
         _produtsLoadedSuccesfully = true;
         dispatch(new MobileInAppPurchaseEvent("mobileProductsLoaded"));
         restorePurchases();
      }
      
      private function onProductsFailed(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling products FAILED:",param1.data);
         _produtsLoadedSuccesfully = false;
         closeProgressSpinner();
      }
      
      private function onInvalidProduct(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling invalid product:",param1.errorCode,param1.message);
      }
      
      private function onPurchaseCancelled(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling purchase cancelled",param1.errorCode);
         mobileApplicationStatusManager.idleTimeoutDuration = 0;
         closeProgressSpinner();
      }
      
      private function onPurchaseFailed(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling purchase failed",param1.errorCode,param1.message);
         mobileApplicationStatusManager.idleTimeoutDuration = 0;
         closeProgressSpinner();
      }
      
      private function onPurchaseSuccess(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling purchase success",param1.errorCode,param1.data);
         mobileApplicationStatusManager.idleTimeoutDuration = 0;
         var _loc5_:Purchase = param1.data[0];
         var _loc4_:Number = -1;
         var _loc3_:String = null;
         for each(var _loc2_ in paymentInfo.goldProducts)
         {
            if(_loc2_.id == _loc5_.productId)
            {
               _loc4_ = Number(_loc5_.quantity);
               _loc3_ = _loc2_.localCurrency;
               break;
            }
         }
         dispatch(new MobileExternalInterfaceEvent("notifySuccessfullPurchase",{
            "purchase":_loc5_,
            "amount":_loc4_,
            "currency":_loc3_
         }));
         closeProgressSpinner();
      }
      
      private function onConsumeSuccess(param1:InAppBillingEvent) : void
      {
         var _loc2_:Purchase = null;
         var _loc3_:Purchase = param1.data[0];
         trace("ANE-SERVICE","InAppBilling consume success :: " + _loc3_.productId,_loc3_.error,_loc3_.errorCode);
         consuming = false;
         if(consumeList.length > 0)
         {
            _loc2_ = consumeList.shift();
            consumePurchase(_loc2_);
         }
      }
      
      private function onConsumeFailed(param1:InAppBillingEvent) : void
      {
         var _loc2_:Purchase = null;
         trace("ANE-SERVICE","InAppBilling consume failed");
         consuming = false;
         if(consumeList.length > 0)
         {
            _loc2_ = consumeList.shift();
            consumePurchase(_loc2_);
         }
      }
      
      private function onRestorePurchaseSuccess(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling restore success",param1.data);
      }
      
      private function onRestorePurchaseFailed(param1:InAppBillingEvent) : void
      {
         trace("ANE-SERVICE","InAppBilling restore failed",param1.data);
      }
      
      public function get produtsLoadedSuccesfully() : Boolean
      {
         return _produtsLoadedSuccesfully;
      }
      
      public function get setupSuccessful() : Boolean
      {
         return _setupSuccessful;
      }
      
      public function consumePurchase(param1:Purchase) : void
      {
         if(!consuming)
         {
            consuming = true;
            InAppBilling.service.consumePurchase(param1);
         }
         else
         {
            consumeList.push(param1);
         }
      }
      
      private function closeProgressSpinner() : void
      {
         if(AirDeviceId.getInstance().isOnIOS)
         {
            dispatch(new MobileAlertDialogsEvent("dismissDialog",null,3,2));
         }
      }
   }
}

