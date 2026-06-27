package wom.view.mediator.screen.popups.expandcity
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.expandcity.MobileExpandCityPopUp;
   
   public class MobileExpandCityPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileExpandCityPopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      public function MobileExpandCityPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         assignDynamicData();
         super.onRegister();
         eventMap.mapStarlingListener(view.confirmButton,"triggered",onConfirmButtonClicked,Event);
      }
      
      protected function onConfirmButtonClicked(param1:Event) : void
      {
         if(view.requiredGold > userInfo.numberOfGolds)
         {
            view.addWindowEnumeration(new WindowEnumeration(0,{"womview":view}));
            view.addWindowEnumeration(new WindowEnumeration(42,{"type":MonetizationType.NOT_ENOUGH_GOLD}));
            closeWindow();
            return;
         }
         closeWindow();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(1003)));
      }
      
      public function assignDynamicData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = city.dimensions.numberOfColumns;
         if(_loc1_ == 200 || _loc1_ == 220 || _loc1_ == 242 || _loc1_ == 268 || _loc1_ == 295)
         {
            _loc4_ = _loc1_ == 200 ? 50 : (_loc1_ == 220 ? 100 : (_loc1_ == 242 ? 150 : (_loc1_ == 268 ? 200 : 250)));
            _loc3_ = _loc1_ == 200 ? 4 : (_loc1_ == 220 ? 3 : (_loc1_ == 242 ? 2 : (_loc1_ == 268 ? 1 : 0)));
         }
         var _loc2_:Number = storeInfo.discount && storeInfo.discount.currency == StoreItemCurrencyType.GOLD && !(1003 in storeInfo.discount.excludedStoreItemIds) ? storeInfo.discount.multiplier : 1;
         view.requiredGold = _loc4_ * _loc2_;
         var _temp_8:* = view;
         var _temp_7:* = "ui.windows.store.availability.buymore";
         var _loc5_:int = _loc3_;
         var _loc6_:String = _temp_7;
         _temp_8.availabilityText = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
      }
   }
}

