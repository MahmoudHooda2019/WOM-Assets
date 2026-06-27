package wom.view.mediator.screen.popups
{
   import flash.geom.Point;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   
   public class MobileBoostConfirmationPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBoostConfirmationPopUp;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileBoostConfirmationPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         if(view.isFinishNowButton)
         {
            eventMap.mapStarlingListener(view.actionButton,"triggered",onFinishBuyButtonClicked,Event);
         }
         else
         {
            eventMap.mapStarlingListener(view.actionButton,"triggered",onBoostBuyButtonClicked,Event);
         }
         addContextListener("storeItemsReady",onStoreItemsReady);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         dispatchGetStoreItemsEvent(null);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.actionButton.localToGlobal(new Point()),param1.additionalInfo,view.actionButton));
      }
      
      private function onFinishBuyButtonClicked(param1:Event) : void
      {
         if(view.finishNowPrice > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else if(view.finishNowPrice == 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,view.instanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,view.instanceId)));
         }
         closeWindow();
      }
      
      private function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         view.storeItemReady(param1.items,storeInfo);
      }
      
      private function onBoostBuyButtonClicked(param1:Event) : void
      {
         if(view.storeItem.id == 1001 && cityInfo.numberOfWorkers > 1)
         {
            view.addWindowEnumeration(new WindowEnumeration(201,{}));
         }
         else if(view.storeItem.currency == StoreItemCurrencyType.GOLD || view.storeItem.currency == StoreItemCurrencyType.RECON_POINTS)
         {
            if(view.storeItem.currency == StoreItemCurrencyType.RECON_POINTS && userInfo.reconPoints < view.storeItem.getPrice(storeInfo.discount))
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
               closeWindow();
               return;
            }
            if(view.storeItem.currency == StoreItemCurrencyType.GOLD && userInfo.numberOfGolds < view.storeItem.getPrice(storeInfo.discount))
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               closeWindow();
               return;
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(view.storeItem.id,view.storeItem.instanceId,view.storeItem.getPrice(storeInfo.discount))));
            soundPlayer.playSfxById("PurchaseSuccessful");
            if(userInfo.mandatoryTutorialCompleted && (view.storeItem.id < 2003 || view.storeItem.id > 2007))
            {
               view.addWindowEnumeration(new WindowEnumeration(202,{"storeItem":view.storeItem}));
            }
         }
         else if(view.storeItem.currency == StoreItemCurrencyType.FREE)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(view.storeItem.id,view.storeItem.instanceId)));
         }
         closeWindow();
      }
      
      protected function dispatchGetStoreItemsEvent(param1:ModelUpdateEvent) : void
      {
         var _loc2_:StoreItemCategory = null;
         switch(view.itemId)
         {
            case 2001:
            case 2002:
            case 2008:
            case 2009:
            case 2010:
            case 2012:
               _loc2_ = StoreItemCategory.SPEEDUPS;
               break;
            case 3013:
               _loc2_ = StoreItemCategory.RESOURCE;
               break;
            case 4005:
            case 4010:
            case 4011:
            case 4012:
               _loc2_ = StoreItemCategory.COMBAT;
         }
         if(_loc2_ != null)
         {
            dispatch(new GetStoreItemsEvent("getStoreItems",_loc2_,view.instanceId));
         }
      }
   }
}

