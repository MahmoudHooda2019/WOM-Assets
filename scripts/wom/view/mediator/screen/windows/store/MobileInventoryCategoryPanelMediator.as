package wom.view.mediator.screen.windows.store
{
   import flash.events.Event;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.command.model.BaseHiringCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.GetInventoryPageEvent;
   import wom.controller.event.ui.InventoryPageReadyEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PageReadyEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.game.inventory.InventoryItemDecorationDTO;
   import wom.model.game.inventory.InventoryItemPartDTO;
   import wom.model.game.inventory.InventoryItemResourceDTO;
   import wom.model.game.inventory.InventoryItemUnitDTO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.SellPartRequest;
   import wom.model.message.request.UseResourceGiftRequest;
   import wom.model.message.request.UseUnitGiftRequest;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.windows.store.MobileInventoryCategoryPanel;
   import wom.view.screen.windows.store.MobileInventoryItemRenderer;
   import wom.view.screen.windows.store.MobileInventoryItemView;
   
   public class MobileInventoryCategoryPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var inventoryCategoryPanel:MobileInventoryCategoryPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileInventoryCategoryPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(inventoryCategoryPanel);
         eventMap.mapStarlingListener(inventoryCategoryPanel.itemList,"rendererAdd",onFromRendererAdded,starling.events.Event);
         eventMap.mapStarlingListener(inventoryCategoryPanel.itemList,"rendererRemove",onFromRendererRemoved,starling.events.Event);
         addContextListener("inventoryUpdated",onInventoryUpdated);
         addContextListener("inventoryPageReady",onPageReady);
         requestInventory();
      }
      
      private function onFromRendererAdded(param1:starling.events.Event, param2:MobileInventoryItemRenderer) : void
      {
         eventMap.mapStarlingListener(param2.iventoryItemView.useButton,"triggered",onUseButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(param2.iventoryItemView.useAllButton,"triggered",onUseAllButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(param2.iventoryItemView.sellButton,"triggered",onSellButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(param2.iventoryItemView.sellAllButton,"triggered",onSellAllButtonClicked,starling.events.Event);
      }
      
      private function onFromRendererRemoved(param1:starling.events.Event, param2:MobileInventoryItemRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.iventoryItemView.useAllButton,"triggered",onUseAllButtonClicked,starling.events.Event);
         eventMap.unmapStarlingListener(param2.iventoryItemView.useButton,"triggered",onUseButtonClicked,starling.events.Event);
         eventMap.unmapStarlingListener(param2.iventoryItemView.sellButton,"triggered",onSellButtonClicked,starling.events.Event);
         eventMap.unmapStarlingListener(param2.iventoryItemView.sellAllButton,"triggered",onSellAllButtonClicked,starling.events.Event);
      }
      
      private function onUseButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:MobileInventoryItemView = null;
         var _loc3_:MobileInventoryItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.iventoryItemView;
            if(_loc2_.isDecorationItem)
            {
               useDecorationItem(_loc2_);
            }
            else if(_loc2_.isResourceItem)
            {
               useResource(false,_loc2_);
            }
            else if(_loc2_.isUnitItem)
            {
               useUnit(_loc2_);
            }
         }
      }
      
      private function onUseAllButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:MobileInventoryItemView = null;
         var _loc3_:MobileInventoryItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.iventoryItemView;
            if(_loc2_.isResourceItem)
            {
               useResource(true,_loc2_);
            }
         }
      }
      
      private function onSellButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:MobileInventoryItemView = null;
         var _loc3_:MobileInventoryItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.iventoryItemView;
            if(_loc2_.isPartItem)
            {
               sellPartItem(false,_loc2_);
            }
         }
      }
      
      private function onSellAllButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:MobileInventoryItemView = null;
         var _loc3_:MobileInventoryItemRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.iventoryItemView;
            if(_loc2_.isPartItem)
            {
               sellPartItem(true,_loc2_);
            }
         }
      }
      
      private function useDecorationItem(param1:MobileInventoryItemView) : void
      {
         var _loc2_:InventoryItemDecorationDTO = param1.decorationItem;
         dispatch(new ActionSelectEvent("actionSelect",ActionType.BUILD));
         coreManager.startBuildDecoration(new DecorationVariationInfo(domainInfo.getDecoration(_loc2_.decorationId),null),true);
         dispatch(new MobilePopUpWindowEvent("closePopUpWindow",inventoryCategoryPanel.parent.parent));
      }
      
      private function useUnit(param1:MobileInventoryItemView) : void
      {
         var _loc2_:InventoryItemUnitDTO = null;
         if(checkBarracksSpaceForItem(param1))
         {
            _loc2_ = param1.unitItem;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new UseUnitGiftRequest(_loc2_.unitTypeAmountDTO.id,_loc2_.unitTypeAmountDTO.amount,1)));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(101)));
         }
      }
      
      private function checkBarracksSpaceForItem(param1:MobileInventoryItemView) : Boolean
      {
         var _loc5_:InventoryItemUnitDTO = param1.unitItem;
         var _loc3_:int = BaseHiringCommand.calculateRemainingBarracksSpace(domainInfo,city,userInfo);
         var _loc4_:int = _loc5_.unitTypeAmountDTO.id;
         var _loc2_:UnitTypeDIO = domainInfo.getUnit(_loc4_);
         var _loc6_:int = _loc4_ in city.unitTypes ? (city.unitTypes[_loc4_] as UnitTypeInfo).currentLevel - 1 : 0;
         return _loc2_.spacesPerLevel[_loc6_] * _loc5_.unitTypeAmountDTO.amount <= _loc3_;
      }
      
      private function useResource(param1:Boolean, param2:MobileInventoryItemView) : void
      {
         var _loc7_:int = 0;
         var _loc3_:flash.events.Event = null;
         var _loc8_:InventoryItemResourceDTO = param2.resourceItem;
         var _loc5_:int = int(param1 ? _loc8_.amount : 1);
         var _loc6_:int = _loc8_.sellingPrice.resourceType;
         var _loc4_:int = city.totalResourceCapacity >> 2;
         if(city.resourceAmounts[_loc6_] >= _loc4_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(79)));
         }
         else if(city.resourceAmounts[_loc6_] + _loc8_.sellingPrice.resourceAmount * _loc5_ > _loc4_)
         {
            _loc7_ = Math.ceil((_loc4_ - city.resourceAmounts[_loc6_]) / _loc8_.sellingPrice.resourceAmount);
            _loc3_ = new OutgoingMessageEvent("outgoingMessage",new UseResourceGiftRequest(_loc8_.id,_loc8_.resourceGiftBonusQuantity,_loc7_));
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("inventory",_loc3_,"closeSecondaryPopUpWindow")));
         }
         else
         {
            param2.useButton.isEnabled = false;
            param2.useAllButton.isEnabled = false;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new UseResourceGiftRequest(_loc8_.id,_loc8_.resourceGiftBonusQuantity,_loc5_)));
         }
      }
      
      private function sellPartItem(param1:Boolean, param2:MobileInventoryItemView) : void
      {
         var _loc7_:int = 0;
         var _loc3_:flash.events.Event = null;
         var _loc8_:InventoryItemPartDTO = param2.partItem;
         var _loc6_:int = _loc8_.sellingPrice.resourceType;
         var _loc5_:int = int(param1 ? _loc8_.amount : 1);
         var _loc4_:int = city.totalResourceCapacity >> 2;
         if(city.resourceAmounts[_loc6_] >= _loc4_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(79)));
         }
         else if(city.resourceAmounts[_loc6_] + _loc8_.sellingPrice.resourceAmount * _loc5_ > _loc4_)
         {
            _loc7_ = Math.ceil((_loc4_ - city.resourceAmounts[_loc6_]) / _loc8_.sellingPrice.resourceAmount);
            _loc3_ = new OutgoingMessageEvent("outgoingMessage",new SellPartRequest(_loc8_.id,_loc7_));
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("inventory",_loc3_,"closeSecondaryPopUpWindow")));
         }
         else
         {
            param2.sellButton.isEnabled = false;
            param2.sellAllButton.isEnabled = false;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SellPartRequest(_loc8_.id,_loc5_)));
         }
      }
      
      private function onInventoryUpdated(param1:ModelUpdateEvent) : void
      {
         requestInventory();
      }
      
      protected function onPageReady(param1:PageReadyEvent) : void
      {
         var _loc2_:InventoryPageReadyEvent = null;
         if(param1 is InventoryPageReadyEvent)
         {
            _loc2_ = param1 as InventoryPageReadyEvent;
            if(_loc2_.inventoryItemCategory.id == inventoryCategoryPanel.category.id)
            {
               inventoryCategoryPanel.updateWithItemList(_loc2_.items,true);
            }
            dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
         }
      }
      
      protected function requestInventory() : void
      {
         dispatch(new GetInventoryPageEvent("getInventoryPage",0,1000,inventoryCategoryPanel.category));
      }
      
      private function checkRendererValidityForClickedButton(param1:MPButton) : MobileInventoryItemRenderer
      {
         var _loc2_:MobileInventoryItemRenderer = null;
         if(param1 && param1.parent && param1.parent.parent && param1.parent.parent is MobileInventoryItemRenderer)
         {
            _loc2_ = param1.parent.parent as MobileInventoryItemRenderer;
            if(_loc2_.inventoryItem)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

