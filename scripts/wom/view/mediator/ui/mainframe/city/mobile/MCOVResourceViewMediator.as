package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.resource.BankResourcesEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.ui.mainframe.city.mobile.MCOVResourceView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProductionProgressInfoView;
   
   public class MCOVResourceViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var resourceView:MCOVResourceView;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MCOVResourceViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(resourceView.boostButton.button,"triggered",onBoostButtonClicked);
         eventMap.mapStarlingListener(resourceView.collectButton,"triggered",onCollectButtonClicked);
         addContextListener("tick",onTick,GameTickEvent);
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
         if(resourceView.boostItem && resourceView.boostItem.effectCooldown)
         {
            changeCooldownText(resourceView.boostItem.effectCooldown.dateEndOfUsage - new Date().getTime());
         }
         else if(_loc1_ in userInfo.storeItemCooldownDurations)
         {
            changeCooldownText(userInfo.storeItemCooldownDurations[_loc1_].infoCreationTime + userInfo.storeItemCooldownDurations[_loc1_].cooldownDuration - new Date().getTime());
         }
         else if(resourceView.boostButton.isCooldownActive())
         {
            resourceView.boostButton.deactivateCooldownLabel();
         }
      }
      
      private function changeCooldownText(param1:Number) : void
      {
         if(!resourceView.boostButton.isCooldownActive())
         {
            resourceView.activateEffectCooldown(param1);
         }
         else
         {
            resourceView.setCooldownText(param1);
         }
      }
      
      private function onBoostButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBoostConfirmationPopUp(determineBoostItemId(),null,-1,-1,resourceView.boostItem.description)));
      }
      
      private function onCollectButtonClicked(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc5_:BuildingTypeDIO = null;
         if(this.buildingTypeDIO.kind.id == 11)
         {
            _loc2_ = false;
            switch(this.buildingInfo.buildingTypeId - 11)
            {
               case 0:
                  if(city.resourceAmounts[ResourceType.LUMBER.id] >= city.totalResourceCapacity >> 2)
                  {
                     _loc2_ = true;
                  }
                  break;
               case 1:
                  if(city.resourceAmounts[ResourceType.STONE.id] >= city.totalResourceCapacity >> 2)
                  {
                     _loc2_ = true;
                  }
                  break;
               case 2:
                  if(city.resourceAmounts[ResourceType.MIGHT.id] >= city.totalResourceCapacity >> 2)
                  {
                     _loc2_ = true;
                  }
                  break;
               case 3:
                  if(city.resourceAmounts[ResourceType.IRON.id] >= city.totalResourceCapacity >> 2)
                  {
                     _loc2_ = true;
                  }
            }
            if(_loc2_)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(79)));
            }
            else
            {
               dispatch(new BankResourcesEvent("bankInstanceResources",this.buildingInfo.instanceId));
            }
         }
         else
         {
            _loc3_ = false;
            _loc6_ = true;
            for each(var _loc7_ in ResourceType.resourceTypes)
            {
               if(_loc6_)
               {
                  _loc6_ = city.resourceAmounts[_loc7_.id] >= city.totalResourceCapacity >> 2;
               }
               if(city.resourceAmounts[_loc7_.id] < city.totalResourceCapacity >> 2)
               {
                  for each(var _loc4_ in city.buildings)
                  {
                     _loc5_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
                     if(_loc5_.kind.id == 11 && (_loc5_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id == _loc7_.id && _loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] >= 1)
                     {
                        _loc3_ = true;
                        break;
                     }
                  }
               }
               if(_loc3_)
               {
                  break;
               }
            }
            if(_loc3_)
            {
               soundPlayer.playSfxById("CollectResource");
            }
            if(_loc6_)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(79)));
            }
            else
            {
               dispatch(new BankResourcesEvent("bankAllResources"));
            }
         }
      }
      
      override protected function updateView() : void
      {
         var _loc1_:String = null;
         super.updateView();
         switch(buildingInfo.buildingTypeId - 11)
         {
            case 0:
               _loc1_ = "ResourceIconLumber";
               break;
            case 1:
               _loc1_ = "ResourceIconStone";
               break;
            case 2:
               _loc1_ = "ResourceIconMight";
               break;
            case 3:
               _loc1_ = "ResourceIconIron";
               break;
            case 4:
               _loc1_ = "IconStockPile";
         }
         resourceView.addInfoView(new MobileBuildingTooltipProductionProgressInfoView(_loc1_,buildingInfo,buildingTypeDIO));
      }
      
      override protected function determineButtonStatus() : void
      {
         super.determineButtonStatus();
         resourceView.boostButton.visible = !(buildingInfo && buildingInfo.buildingTypeId == 15 && (resourceView.fortifyButton.visible && resourceView.upgradeButton.visible));
         resourceView.drawLayout();
      }
      
      private function determineBoostItemId() : int
      {
         if(buildingTypeDIO.kind.id == 11)
         {
            return 2002;
         }
         return 3013;
      }
      
      private function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = determineBoostItemId();
         for each(var _loc4_ in param1.items)
         {
            if(_loc4_.effectCooldown == null && _loc4_.id == _loc2_)
            {
               resourceView.boostItem = _loc4_;
               if(_loc4_.effectCooldown == null && _loc4_.locked)
               {
                  resourceView.boostButton.visible = false;
                  resourceView.drawLayout();
               }
               else
               {
                  _loc3_ = _loc4_.getOriginalPrice();
                  _loc3_ *= storeInfo.discount && storeInfo.discount.currency == StoreItemCurrencyType.GOLD && !(_loc2_ in storeInfo.discount.excludedStoreItemIds) ? storeInfo.discount.multiplier : 1;
                  resourceView.boostButton.subLabel = _loc3_.toString();
               }
               return;
            }
         }
      }
      
      private function dispatchGetStoreItemsEvent() : void
      {
         var _loc1_:StoreItemCategory = null;
         if(buildingTypeDIO.kind.id == 11)
         {
            _loc1_ = StoreItemCategory.SPEEDUPS;
         }
         else
         {
            _loc1_ = StoreItemCategory.RESOURCE;
         }
         dispatch(new GetStoreItemsEvent("getStoreItems",_loc1_));
      }
   }
}

