package wom.view.mediator.ui.mainframe.city.mobile
{
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.ui.mainframe.city.mobile.MCOVDefensiveView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipDefenseInfoView;
   
   public class MCOVDefensiveViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var defensiveView:MCOVDefensiveView;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MCOVDefensiveViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(defensiveView.boostButton.button,"triggered",onBoostButtonClicked);
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("storeItemsReady",onStoreItemsReady);
         dispatch(new GetStoreItemsEvent("getStoreItems",StoreItemCategory.COMBAT));
         checkCooldown();
      }
      
      private function onBoostButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBoostConfirmationPopUp(4012)));
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         var _loc1_:int = buildingInfo.level > 0 ? buildingInfo.level - 1 : 0;
         defensiveView.addInfoView(new MobileBuildingTooltipDefenseInfoView(buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][_loc1_],buildingTypeDIO.healthPointsPerLevel[_loc1_]));
      }
      
      private function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = 4012;
         for each(var _loc4_ in param1.items)
         {
            if(_loc4_.id == _loc2_)
            {
               defensiveView.boostItem = _loc4_;
               if(_loc4_.effectCooldown == null && _loc4_.locked)
               {
                  defensiveView.boostButton.visible = false;
                  defensiveView.drawLayout();
               }
               else
               {
                  _loc3_ = _loc4_.getOriginalPrice();
                  _loc3_ *= storeInfo.discount && storeInfo.discount.currency == StoreItemCurrencyType.GOLD && !(_loc2_ in storeInfo.discount.excludedStoreItemIds) ? storeInfo.discount.multiplier : 1;
                  defensiveView.boostButton.subLabel = _loc3_.toString();
               }
               return;
            }
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         checkCooldown();
      }
      
      private function checkCooldown() : void
      {
         var _loc1_:int = 4012;
         if(defensiveView.boostItem && defensiveView.boostItem.effectCooldown)
         {
            changeCooldownText(defensiveView.boostItem.effectCooldown.dateEndOfUsage - new Date().getTime());
         }
         else if(_loc1_ in userInfo.storeItemCooldownDurations)
         {
            changeCooldownText(userInfo.storeItemCooldownDurations[_loc1_].infoCreationTime + userInfo.storeItemCooldownDurations[_loc1_].cooldownDuration - new Date().getTime());
         }
         else if(defensiveView.boostButton.isCooldownActive())
         {
            defensiveView.boostButton.deactivateCooldownLabel();
         }
      }
      
      private function changeCooldownText(param1:Number) : void
      {
         if(!defensiveView.boostButton.isCooldownActive())
         {
            defensiveView.activateEffectCooldown(param1);
         }
         else
         {
            defensiveView.setCooldownText(param1);
         }
      }
   }
}

