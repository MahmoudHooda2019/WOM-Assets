package wom.view.mediator.screen.windows.activate
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.model.game.inventory.PartSellPriceCalculationUtil;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.model.message.request.BuyPartRequest;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.activate.MobileRequiredItemView;
   
   public class MobileRequiredItemViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRequiredItemView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileRequiredItemViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         onInventoryUpdated(null);
         view.partTypeDIO = domainInfo.getPart(view.partItemDTO.id);
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.itemAsset,"change",onItemAssetChange,Event);
         eventMap.mapStarlingListener(view.buyWithGoldButton,"triggered",onBuyWithGoldClicked,Event);
         eventMap.mapStarlingListener(view.buyWithRPButton,"triggered",onBuyWithRPClicked,Event);
         eventMap.mapStarlingListener(view.askAFriendButton,"triggered",onAskAFriendClicked,Event);
         addContextListener("inventoryUpdated",onInventoryUpdated);
      }
      
      private function onItemAssetChange(param1:Event) : void
      {
         view.itemAsset.visible = true;
         view.drawLayout();
      }
      
      private function onBuyWithGoldClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.partTypeDIO.buyingGoldPrice)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold",view.buildingTypeDIO != null ? MonetizationType.FINISH_BUILDING : MonetizationType.NOT_ENOUGH_GOLD)));
            return;
         }
         soundPlayer.playSfxById("PurchaseSuccessful");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyPartRequest(view.partItemDTO.id,1)));
      }
      
      private function onBuyWithRPClicked(param1:Event) : void
      {
         if(userInfo.reconPoints < view.partTypeDIO.buyingRPPrice)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
            return;
         }
         soundPlayer.playSfxById("PurchaseSuccessful");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyPartRequest(view.partItemDTO.id,1,true)));
      }
      
      private function onAskAFriendClicked(param1:Event) : void
      {
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
         if(mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            if(view.askForMore)
            {
               dispatch(new MobileExternalInterfaceEvent("getBlockedFriends",{
                  "type":5,
                  "subtype":view.partTypeDIO.id,
                  "subsubtype":(view.buildingTypeDIO != null ? view.buildingTypeDIO.id : -1)
               }));
            }
            else
            {
               dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",2,view.partItemDTO.id));
            }
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp()));
         }
      }
      
      private function onInventoryUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc2_:InventoryItemDTO = null;
         var _loc3_:PartTypeDIO = null;
         for each(var _loc4_ in userInfo.items)
         {
            if(_loc4_.category == InventoryItemCategory.PARTS && view.partItemDTO.id == _loc4_.id)
            {
               _loc2_ = _loc4_;
            }
         }
         if(_loc2_ == null)
         {
            _loc3_ = domainInfo.getPart(view.partItemDTO.id);
            _loc2_ = new InventoryItemPartDTO(_loc3_.id,_loc3_.visual,0,_loc3_.buyingGoldPrice,_loc3_.buyingRPPrice,PartSellPriceCalculationUtil.calculateSellPrice(_loc3_,domainInfo.getBuilding(10),city,ResourceQuantityType.DEFAULT),_loc3_.usedInBuildingIds);
         }
         view.inventoryItemDTO = _loc2_;
         if(param1 != null)
         {
            view.drawLayout();
         }
      }
   }
}

