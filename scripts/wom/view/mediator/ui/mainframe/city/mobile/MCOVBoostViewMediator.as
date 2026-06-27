package wom.view.mediator.ui.mainframe.city.mobile
{
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.ui.mainframe.city.mobile.MCOVBoostView;
   
   public class MCOVBoostViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var boostView:MCOVBoostView;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      public function MCOVBoostViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(boostView.boostButton.button,"triggered",onBoostButtonClicked);
         addContextListener("tick",onTick,GameTickEvent);
         boostView.boostButton.iconId = determineBoostIconAsset(buildingInfo.buildingTypeId);
         boostView.boostButton.boostAmountLabel = determineBoostAmount(buildingInfo.buildingTypeId);
         addContextListener("storeItemsReady",onStoreItemsReady);
         dispatchGetStoreItemsEvent();
         checkCooldown();
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         checkCooldown();
      }
      
      private function checkCooldown() : void
      {
         var _loc1_:int = determineBoostItemId();
         if(boostView.boostItem && boostView.boostItem.effectCooldown)
         {
            changeCooldownText(boostView.boostItem.effectCooldown.dateEndOfUsage - new Date().getTime());
         }
         else if(_loc1_ in userInfo.storeItemCooldownDurations)
         {
            changeCooldownText(userInfo.storeItemCooldownDurations[_loc1_].infoCreationTime + userInfo.storeItemCooldownDurations[_loc1_].cooldownDuration - new Date().getTime());
         }
         else if(boostView.boostButton.isCooldownActive())
         {
            boostView.boostButton.deactivateCooldownLabel();
         }
      }
      
      private function changeCooldownText(param1:Number) : void
      {
         if(!boostView.boostButton.isCooldownActive())
         {
            boostView.activateEffectCooldown(param1);
         }
         else
         {
            boostView.setCooldownText(param1);
         }
      }
      
      private function onBoostButtonClicked() : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBoostConfirmationPopUp(determineBoostItemId())));
      }
      
      private function determineBoostItemId() : int
      {
         switch(buildingInfo.buildingTypeId - 19)
         {
            case 0:
               return 4011;
            case 1:
            case 2:
               return 2012;
            default:
               return 0;
         }
      }
      
      private function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = determineBoostItemId();
         for each(var _loc4_ in param1.items)
         {
            if(_loc4_.id == _loc2_)
            {
               boostView.boostItem = _loc4_;
               _loc3_ = _loc4_.getOriginalPrice();
               _loc3_ *= storeInfo.discount && storeInfo.discount.currency == StoreItemCurrencyType.GOLD && !(_loc2_ in storeInfo.discount.excludedStoreItemIds) ? storeInfo.discount.multiplier : 1;
               boostView.boostButton.subLabel = String(_loc3_ >> 0);
               return;
            }
         }
      }
      
      private function dispatchGetStoreItemsEvent() : void
      {
         var _loc1_:StoreItemCategory = null;
         switch(buildingInfo.buildingTypeId - 19)
         {
            case 0:
               _loc1_ = StoreItemCategory.COMBAT;
               break;
            case 1:
            case 2:
               _loc1_ = StoreItemCategory.SPEEDUPS;
         }
         dispatch(new GetStoreItemsEvent("getStoreItems",_loc1_));
      }
      
      private function determineBoostIconAsset(param1:int) : String
      {
         switch(param1 - 19)
         {
            case 0:
               return "BoostIconBarrack";
            case 1:
               return "BoostIconHiring";
            case 2:
               return "BoostIconHiring";
            default:
               return null;
         }
      }
      
      private function determineBoostAmount(param1:int) : String
      {
         switch(param1 - 19)
         {
            case 0:
               return "25%";
            case 1:
            case 2:
               return "X5";
            default:
               return "";
         }
      }
   }
}

