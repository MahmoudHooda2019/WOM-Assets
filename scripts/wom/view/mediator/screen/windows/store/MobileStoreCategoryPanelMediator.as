package wom.view.mediator.screen.windows.store
{
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.screen.popups.MobileStoreItemPurchasedPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.store.MobileHireWorkerWindow;
   import wom.view.screen.windows.store.MobileStoreCategoryPanel;
   import wom.view.screen.windows.store.MobileStoreItemRenderer;
   import wom.view.screen.windows.store.MobileStoreItemView;
   
   public class MobileStoreCategoryPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var storeCategoryPanel:MobileStoreCategoryPanel;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var injector:IInjector;
      
      private var lastUpdate:Number;
      
      private var pageRequested:Boolean;
      
      public function MobileStoreCategoryPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(storeCategoryPanel);
         eventMap.mapStarlingListener(storeCategoryPanel.itemList,"rendererAdd",onFromRendererAdded,Event);
         eventMap.mapStarlingListener(storeCategoryPanel.itemList,"rendererRemove",onFromRendererRemoved,Event);
         addContextListener("storeItemsReady",onStoreItemsReady);
         addContextListener("storeItemEffectsUpdated",dispatchGetStoreItemsEvent);
         addContextListener("goldAmountUpdated",onGoldAmountUpdated,ModelUpdateEvent);
         addContextListener("resourcesUpdated",onResourceAmountUpdated,ModelUpdateEvent);
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("getBuyExtraWorkerPosition",onGetBuyExtraWorkerPositionRequested,TutorialReferencePositionEvent);
         setTimeout(dispatchGetStoreItemsEventWithDelay,1);
      }
      
      private function onFromRendererAdded(param1:Event, param2:MobileStoreItemRenderer) : void
      {
         eventMap.mapStarlingListener(param2.storeItemView.buyButton,"triggered",onStoreItemViewBuyButtonClicked,Event);
         eventMap.mapStarlingListener(param2.storeItemView.discountedBuyButton,"triggered",onStoreItemViewBuyButtonClicked,Event);
         eventMap.mapStarlingListener(param2.storeItemView.hintButton,"triggered",onHintButtonClicked,Event);
         eventMap.mapStarlingListener(param2.storeItemInfoView.hintButton,"triggered",onHintButtonClicked,Event);
         addContextListener("tick",param2.storeItemView.onTick,GameTickEvent);
         addContextListener("storeItemDiscountUpdated",param2.storeItemView.onStoreItemDiscountUpdated,ModelUpdateEvent);
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileStoreItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc2_)
         {
            _loc2_.onHintButtonClicked();
         }
      }
      
      private function onFromRendererRemoved(param1:Event, param2:MobileStoreItemRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.storeItemView.buyButton,"triggered",onStoreItemViewBuyButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.storeItemView.discountedBuyButton,"triggered",onStoreItemViewBuyButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.storeItemView.hintButton,"triggered",onHintButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.storeItemInfoView.hintButton,"triggered",onHintButtonClicked,Event);
         removeContextListener("tick",param2.storeItemView.onTick,GameTickEvent);
         removeContextListener("storeItemDiscountUpdated",param2.storeItemView.onStoreItemDiscountUpdated,ModelUpdateEvent);
      }
      
      private function onStoreItemViewBuyButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileStoreItemView = null;
         var _loc3_:MobileStoreItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.storeItemView;
            if(_loc2_.storeItem.id == 1001 && cityInfo.numberOfWorkers > 1)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHireWorkerWindow()));
               closeParentWindow(false,_loc2_);
            }
            else if(_loc2_.storeItem.currency == StoreItemCurrencyType.GOLD || _loc2_.storeItem.currency == StoreItemCurrencyType.RECON_POINTS)
            {
               if(_loc2_.storeItem.currency == StoreItemCurrencyType.RECON_POINTS && userInfo.reconPoints < _loc2_.storeItem.getPrice(storeInfo.discount))
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
                  return;
               }
               if(_loc2_.storeItem.currency == StoreItemCurrencyType.GOLD && userInfo.numberOfGolds < _loc2_.storeItem.getPrice(storeInfo.discount))
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
                  return;
               }
               closeParentWindow(_loc2_.storeItem.id != 1001,_loc2_);
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(_loc2_.storeItem.id,_loc2_.storeItem.instanceId,_loc2_.storeItem.getPrice(storeInfo.discount))));
               soundPlayer.playSfxById("PurchaseSuccessful");
               if(userInfo.mandatoryTutorialCompleted && (_loc2_.storeItem.id < 2003 || _loc2_.storeItem.id > 2007))
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileStoreItemPurchasedPopUp(_loc2_.storeItem)));
               }
            }
            else if(_loc2_.storeItem.currency == StoreItemCurrencyType.FREE)
            {
               closeParentWindow(true,_loc2_);
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(_loc2_.storeItem.id,_loc2_.storeItem.instanceId)));
            }
            if(storeCategoryPanel.instanceId != -1)
            {
               closeParentWindow(false,_loc2_);
            }
         }
      }
      
      private function closeParentWindow(param1:Boolean, param2:MobileStoreItemView) : void
      {
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",param2,param1));
      }
      
      private function dispatchGetStoreItemsEventWithDelay() : void
      {
         dispatchGetStoreItemsEvent(null);
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onGetBuyExtraWorkerPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc4_:Object = null;
         var _loc6_:StoreItemInfo = null;
         var _loc2_:ListCollection = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Point = null;
         if(storeCategoryPanel.itemList && storeCategoryPanel.itemList.dataProvider)
         {
            _loc2_ = storeCategoryPanel.itemList.dataProvider;
            _loc5_ = _loc2_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc4_ = _loc2_.getItemAt(_loc7_);
               if("storeItemInfo" in _loc4_ && _loc4_.storeItemInfo)
               {
                  _loc6_ = _loc4_.storeItemInfo as StoreItemInfo;
                  if(_loc6_.id == 1001)
                  {
                     (storeCategoryPanel.itemList.layout as TiledColumnsLayout).horizontalAlign = "left";
                     storeCategoryPanel.itemList.scrollToPageIndex("hpi" in param1.additionalInfo ? param1.additionalInfo["hpi"] : 0,"vpi" in param1.additionalInfo ? param1.additionalInfo["vpi"] : 0);
                     storeCategoryPanel.itemList.horizontalScrollPolicy = "off";
                     storeCategoryPanel.itemList.verticalScrollPolicy = "off";
                     _loc3_ = storeCategoryPanel.itemList.localToGlobal(new Point(0,0));
                     dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc3_,param1.additionalInfo));
                     break;
                  }
               }
               _loc7_++;
            }
         }
      }
      
      protected function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         lastUpdate = new Date().getTime();
         pageRequested = false;
         if(storeCategoryPanel.category == param1.category)
         {
            storeCategoryPanel.updateWithItemList(param1.items,true);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(storeCategoryPanel.category == StoreItemCategory.SPEEDUPS && storeCategoryPanel.instanceId != -1 && !pageRequested)
         {
            if(lastUpdate - new Date().getTime() > 1000)
            {
               pageRequested = true;
               dispatchGetStoreItemsEvent(null);
            }
         }
      }
      
      protected function dispatchGetStoreItemsEvent(param1:ModelUpdateEvent) : void
      {
         var _loc2_:int = -1;
         if(storeCategoryPanel.category == StoreItemCategory.SPEEDUPS || storeCategoryPanel.category == StoreItemCategory.BUILDING_SPEEDUPS)
         {
            _loc2_ = storeCategoryPanel.instanceId;
         }
         dispatch(new GetStoreItemsEvent("getStoreItems",storeCategoryPanel.category,_loc2_));
      }
      
      private function onGoldAmountUpdated(param1:ModelUpdateEvent) : void
      {
         dispatchGetStoreItemsEvent(param1);
      }
      
      private function onResourceAmountUpdated(param1:ModelUpdateEvent) : void
      {
         dispatchGetStoreItemsEvent(param1);
      }
      
      private function checkRendererValidityForClickedButton(param1:MPButton) : MobileStoreItemRenderer
      {
         var _loc2_:MobileStoreItemRenderer = null;
         if(param1 && param1.parent && param1.parent.parent && param1.parent.parent is MobileStoreItemRenderer)
         {
            _loc2_ = param1.parent.parent as MobileStoreItemRenderer;
            if(_loc2_.storeItemData)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

