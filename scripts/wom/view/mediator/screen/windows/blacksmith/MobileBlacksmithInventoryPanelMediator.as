package wom.view.mediator.screen.windows.blacksmith
{
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.model.CapacityExceedEvent;
   import wom.controller.event.model.NotEnoughGoldEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.message.request.CancelEventItemBuildRequest;
   import wom.model.message.request.FinishEventItemBuildRequest;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithInventoryPanel;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithInventoryRenderer;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithInventorySlotView;
   
   public class MobileBlacksmithInventoryPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileBlacksmithInventoryPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var eventItemUtil2:EventItemUtil2;
      
      public function MobileBlacksmithInventoryPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.blacksmithCurrentLevel = getBlacksmithLevel();
         super.onRegister();
         eventMap.mapStarlingListener(view.inventoryItemList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.inventoryItemList,"rendererRemove",onRendererRemoved,Event);
         updateSlots();
         addContextListener("eventItemQueueUpdated",onModelUpdated,ModelUpdateEvent);
      }
      
      private function onModelUpdated(param1:ModelUpdateEvent) : void
      {
         updateSlots();
      }
      
      private function updateSlots() : void
      {
         view.fillInventory(eventItemUtil2.getInventoryEventItems());
      }
      
      private function onRendererAdded(param1:Event, param2:MobileBlacksmithInventoryRenderer) : void
      {
         eventMap.mapStarlingListener(param2.slotView.minusButton,"triggered",onMinusButtonClicked,Event);
         eventMap.mapStarlingListener(param2.slotView.finishNowButton,"triggered",onFinishNowButtonClicked,Event);
         addContextListener("tick",param2.slotView.updateProgress,GameTickEvent);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileBlacksmithInventoryRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.slotView.minusButton,"triggered",onMinusButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.slotView.finishNowButton,"triggered",onFinishNowButtonClicked,Event);
         removeContextListener("tick",param2.slotView.updateProgress,GameTickEvent);
      }
      
      private function onMinusButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileBlacksmithInventorySlotView = null;
         var _loc3_:MobileBlacksmithInventoryRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.slotView;
            view.lastModifiedItemIndex = _loc2_.slotIndex == 0 ? 0 : _loc2_.slotIndex - 1;
            for each(var _loc4_ in getResourceCosts(_loc2_.eventItemDIO,eventItemUtil2.getCurrentLevelIndex(_loc2_.eventItemDIO)))
            {
               if(city.resourceAmounts[_loc4_.resourceType] + _loc4_.resourceAmount > city.totalResourceCapacity >> 2)
               {
                  dispatch(new CapacityExceedEvent("capacityexceedinblacksmith",_loc2_.slotIndex));
                  return;
               }
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelEventItemBuildRequest(_loc2_.slotIndex)));
         }
      }
      
      private function onFinishNowButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileBlacksmithInventorySlotView = null;
         var _loc3_:MobileBlacksmithInventoryRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc3_)
         {
            _loc2_ = _loc3_.slotView;
            if(userInfo.numberOfGolds < _loc2_.requiredGoldForFinish)
            {
               dispatch(new NotEnoughGoldEvent("blacksmithFinishNow"));
            }
            else
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new FinishEventItemBuildRequest(_loc2_.slotIndex)));
            }
            view.lastModifiedItemIndex = _loc2_.slotIndex;
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:MPButton) : MobileBlacksmithInventoryRenderer
      {
         var _loc2_:MobileBlacksmithInventoryRenderer = null;
         if(param1 && param1.parent && param1.parent.parent && param1.parent.parent is MobileBlacksmithInventoryRenderer)
         {
            _loc2_ = param1.parent.parent as MobileBlacksmithInventoryRenderer;
            if(_loc2_.slotView)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getBlacksmithLevel() : int
      {
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 44)
            {
               return _loc1_.level;
            }
         }
         return 0;
      }
      
      private function getResourceCosts(param1:EventItemDIO, param2:int) : Vector.<ResourceAmountDTO>
      {
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               return domainInfo.getUnit(param1.relatedId).hiringCostsPerLevel[param2];
            case EventItemType.CATAPULT.id:
               return domainInfo.getCatapult(param1.relatedId).resourceCosts[param2];
            default:
               return null;
         }
      }
   }
}

