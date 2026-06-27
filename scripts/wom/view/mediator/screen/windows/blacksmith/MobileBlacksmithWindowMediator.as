package wom.view.mediator.screen.windows.blacksmith
{
   import peak.i18n.PText;
   import peak.messaging.OutgoingMessage;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.model.CapacityExceedEvent;
   import wom.controller.event.model.NotEnoughGoldEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuildEventItemRequest;
   import wom.model.message.request.CancelEventItemBuildRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithWindow;
   
   public class MobileBlacksmithWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBlacksmithWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var eventItemUtil2:EventItemUtil2;
      
      public function MobileBlacksmithWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.selectEventItemPanel.eventItemInfoPanel.prepareButton,"triggered",onPrepareButtonClicked,Event);
         addContextListener("capacityexceedinblacksmith",onCapacityExceed);
         addContextListener("blacksmithFinishNow",onFinishNowNotEnoughGold);
      }
      
      private function isEventItemAvailable(param1:*) : Boolean
      {
         for each(var _loc2_ in userInfo.unlockedEventItems)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onPrepareButtonClicked() : void
      {
         var _loc10_:EventItemDIO = null;
         var _loc4_:Array = null;
         var _loc7_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc12_:int = 0;
         var _loc11_:ResourceAmountDTO = null;
         var _loc6_:int = 0;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc1_:OutgoingMessage = null;
         var _loc9_:int = view.selectEventItemPanel.eventItemInfoPanel.eventItemDIO.id;
         if(isEventItemAvailable(_loc9_))
         {
            if(!hasEmptyInventorySlot())
            {
               var _temp_2:* = §§findproperty(MobileUINotificationEvent);
               var _temp_1:* = "mobileUINotificationEventShow";
               var _loc15_:String = "m.ui.windows.blacksmith.inventory.full";
               dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc15_)));
               return;
            }
            _loc10_ = view.selectEventItemPanel.eventItemInfoPanel.eventItemDIO;
            _loc4_ = city.resourceAmounts;
            _loc7_ = getResourceCosts(_loc10_);
            _loc2_ = true;
            _loc12_ = 0;
            while(_loc12_ < _loc7_.length)
            {
               _loc11_ = _loc7_[_loc12_];
               if(_loc2_)
               {
                  _loc2_ = _loc4_[_loc11_.resourceType] >= _loc11_.resourceAmount;
               }
               _loc12_++;
            }
            view.inventoryPanel.lastModifiedItemIndex = eventItemUtil2.getInventoryEventItems().length;
            if(_loc2_)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuildEventItemRequest(_loc10_.id,false)));
            }
            else
            {
               _loc6_ = 0;
               _loc5_ = [];
               for each(var _loc3_ in getResourceCosts(_loc10_))
               {
                  _loc8_ = _loc3_.resourceAmount - city.resourceAmounts[_loc3_.resourceType];
                  if(_loc8_ > 0)
                  {
                     _loc5_.push({
                        "resourceType":_loc3_.resourceType,
                        "amount":_loc8_
                     });
                     _loc6_ += _loc8_;
                  }
               }
               if(_loc6_ > 0)
               {
                  _loc1_ = new BuildEventItemRequest(_loc10_.id,true);
                  view.addWindowEnumeration(new WindowEnumeration(46,{"lastModifiedItemIndex":view.inventoryPanel.lastModifiedItemIndex}));
                  view.addWindowEnumeration(new WindowEnumeration(43,{
                     "type":"blacksmith",
                     "missingResourcesArray":_loc5_,
                     "outgoingMessage":_loc1_,
                     "windowEnumerations":view.windowEnumerations
                  }));
                  closeWindow();
               }
            }
         }
         else
         {
            var _temp_6:* = §§findproperty(MobileUINotificationEvent);
            var _temp_5:* = "mobileUINotificationEventShow";
            var _loc16_:String = "m.ui.windows.blacksmith.unlockitem";
            dispatch(new MobileUINotificationEvent(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc16_)));
         }
      }
      
      private function onCapacityExceed(param1:CapacityExceedEvent) : void
      {
         var _loc2_:OutgoingMessageEvent = new OutgoingMessageEvent("outgoingMessage",new CancelEventItemBuildRequest(param1.index));
         view.addWindowEnumeration(new WindowEnumeration(46,{"lastModifiedItemIndex":view.inventoryPanel.lastModifiedItemIndex}));
         view.addWindowEnumeration(new WindowEnumeration(45,{
            "type":"blacksmith",
            "confirmEvent":_loc2_,
            "windowEnumerations":view.windowEnumerations
         }));
         closeWindow();
      }
      
      private function onFinishNowNotEnoughGold(param1:NotEnoughGoldEvent) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(46,{"lastModifiedItemIndex":view.inventoryPanel.lastModifiedItemIndex}));
         view.addWindowEnumeration(new WindowEnumeration(42,{"type":MonetizationType.NOT_ENOUGH_GOLD}));
         closeWindow();
      }
      
      private function getResourceCosts(param1:EventItemDIO) : Vector.<ResourceAmountDTO>
      {
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               return domainInfo.getUnit(param1.relatedId).hiringCostsPerLevel[0];
            case EventItemType.CATAPULT.id:
               return domainInfo.getCatapult(param1.relatedId).resourceCosts[0];
            default:
               return null;
         }
      }
      
      private function hasEmptyInventorySlot() : Boolean
      {
         return 5 + getBlacksmithLevel() - eventItemUtil2.getInventoryEventItems().length > 0;
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
   }
}

