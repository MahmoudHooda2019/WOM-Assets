package wom.view.mediator.screen.popups
{
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileInAppPurchaseEvent;
   import wom.model.game.UserInfo;
   import wom.service.mobile.MobileInAppPurchaseService;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileSpecialOfferPopUp;
   
   public class MobileSpecialOfferPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var offerView:MobileSpecialOfferPopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var mobileInAppPurchaseService:MobileInAppPurchaseService;
      
      public function MobileSpecialOfferPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         onMobileSpecialOfferUpdated(null);
         _eventMap.mapStarlingListener(offerView.actionButton,"triggered",onBuyButtonClicked,Event);
         addContextListener("mobileSpecialOfferUpdated",onMobileSpecialOfferUpdated,ModelUpdateEvent);
         addContextListener("tick",onTick,GameTickEvent);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = offerView.specialOfferDTO.expireDate * 1000 - new Date().getTime();
         if(_loc2_ > 0)
         {
            var _temp_2:* = offerView.offerTimeLeftTextField;
            var _temp_1:* = "m.ui.popups.specialoffer.offertimeleft";
            var _loc3_:String = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_loc2_);
            var _loc4_:String = _temp_1;
            _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         }
         else
         {
            closeWindow();
         }
      }
      
      private function onMobileSpecialOfferUpdated(param1:ModelUpdateEvent) : void
      {
         offerView.updateWithSpecialOfferInfo(userInfo.mobileSpecialOffer);
      }
      
      private function onBuyButtonClicked(param1:Event) : void
      {
         var _loc2_:Object = {
            "productId":userInfo.mobileSpecialOffer.hashed_id,
            "amountOfGold":userInfo.mobileSpecialOffer.goldAmount,
            "peakPayId":userInfo.mobileSpecialOffer.peakPayId
         };
         dispatch(new MobileInAppPurchaseEvent("preparePurchase",_loc2_));
         closeWindow();
      }
   }
}

