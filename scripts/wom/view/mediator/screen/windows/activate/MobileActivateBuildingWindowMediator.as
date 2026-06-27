package wom.view.mediator.screen.windows.activate
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.message.request.ActivateBuildingRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.activate.MobileActivateBuildingWindow;
   
   public class MobileActivateBuildingWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileActivateBuildingWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileActivateBuildingWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         view.buildingTypeDIO = domainInfo.getBuilding(view.buildingInfo.buildingTypeId);
         addContextListener("inventoryUpdated",onInventoryUpdated);
         eventMap.mapStarlingListener(view.finishBuildingButton,"triggered",onFinishButtonClicked,Event);
         eventMap.mapStarlingListener(view.buyAllForButton,"triggered",onBuyAllForButtonClicked,Event);
         view.addRequiredItemViews();
         determineButtonStatus();
      }
      
      private function onInventoryUpdated(param1:ModelUpdateEvent) : void
      {
         determineButtonStatus();
      }
      
      private function determineButtonStatus() : void
      {
         var _loc8_:int = 0;
         var _loc3_:PartInfoDTO = null;
         var _loc4_:Boolean = false;
         var _loc1_:int = 0;
         var _loc5_:Boolean = true;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < view.requirements.length)
         {
            _loc3_ = view.requirements[_loc8_];
            _loc4_ = false;
            for each(var _loc2_ in userInfo.items)
            {
               if(_loc2_.category == InventoryItemCategory.PARTS && _loc2_.id == _loc3_.id)
               {
                  _loc4_ = true;
                  if(_loc5_)
                  {
                     _loc5_ = _loc3_.amount <= _loc2_.amount;
                  }
                  if(_loc3_.amount > _loc2_.amount)
                  {
                     _loc1_ = _loc3_.amount - _loc2_.amount;
                  }
                  else
                  {
                     _loc1_ = 0;
                  }
               }
            }
            if(!_loc4_)
            {
               _loc5_ = false;
               _loc1_ = _loc3_.amount;
            }
            _loc7_ += _loc1_;
            _loc6_ += _loc1_ * domainInfo.getPart(_loc3_.id).buyingGoldPrice;
            _loc8_++;
         }
         view.finishBuildingButton.isEnabled = _loc5_;
         view.buyAllForButton.visible = !_loc5_;
         view.promotionText.visible = _loc7_ > 1;
         if(_loc7_ > 1)
         {
            _loc6_ = _loc6_ * 0.8 << 0;
         }
         view.buyAllForRequiredGold = _loc6_;
         view.buyAllForButton.rightLabel = view.buyAllForRequiredGold + "";
         view.drawLayout();
      }
      
      private function onFinishButtonClicked(param1:Event) : void
      {
         closeWindow();
         if(view.buildingTypeDIO.isHealthy(view.buildingInfo.level,view.buildingInfo.healthPoint))
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ActivateBuildingRequest(view.buildingInfo.instanceId)));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileActionNotPossiblePopup(81)));
         }
      }
      
      private function onBuyAllForButtonClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.buyAllForRequiredGold)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold",MonetizationType.FINISH_BUILDING)));
            return;
         }
         closeWindow();
         soundPlayer.playSfxById("PurchaseSuccessful");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ActivateBuildingRequest(view.buildingInfo.instanceId,true)));
      }
   }
}

