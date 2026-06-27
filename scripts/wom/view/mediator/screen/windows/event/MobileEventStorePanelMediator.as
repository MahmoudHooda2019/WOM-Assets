package wom.view.mediator.screen.windows.event
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.message.request.UnlockEventItemRequest;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.event.MobileEventStoreItemViewRenderer;
   import wom.view.screen.windows.event.MobileEventStorePanel;
   
   public class MobileEventStorePanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileEventStorePanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileEventStorePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("storeItemsReady",onStoreItemsReady);
         addContextListener("eventItemsUpdated",onEventItemsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.itemList,"rendererAdd",onRendererAdded,Event);
         dispatchGetStoreItemsEvent();
      }
      
      protected function onStoreItemsReady(param1:StoreItemsReadyEvent) : void
      {
         if(StoreItemCategory.EVENT == param1.category)
         {
            if(view.itemList.dataProvider)
            {
               view.updateAllItems(param1.items,domainInfo.getEventItems(),getItemSpecificDIOs(),userInfo.unlockedEventItems);
            }
            else
            {
               view.fillItems(param1.items,domainInfo.getEventItems(),getItemSpecificDIOs(),userInfo.unlockedEventItems);
            }
         }
      }
      
      private function onRendererAdded(param1:Event, param2:MobileEventStoreItemViewRenderer = null) : void
      {
         eventMap.mapStarlingListener(param2.itemView.unlockButton,"triggered",onUnlockButtonClicked,Event);
      }
      
      private function onUnlockButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileEventStoreItemViewRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         var _loc3_:EventStoreItemInfo = _loc2_.itemView.eventStoreItemInfo;
         if(view.allowItemUnlocking)
         {
            if(_loc3_.unlockCost > userInfo.eventPoints)
            {
               var _temp_2:* = §§findproperty(MobileUINotificationEvent);
               var _temp_1:* = "mobileUINotificationEventShow";
               var _loc4_:String = "ui.popups.notenough.event.header";
               dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_)));
            }
            else
            {
               dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
               dispatch(new OutgoingMessageEvent("outgoingMessage",new UnlockEventItemRequest(_loc3_.id)));
            }
         }
         else
         {
            var _temp_5:* = §§findproperty(MobileUINotificationEvent);
            var _temp_4:* = "mobileUINotificationEventShow";
            var _loc5_:String = "ui.windows.eventstore.shadowtext";
            dispatch(new MobileUINotificationEvent(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc5_)));
         }
      }
      
      private function onEventItemsUpdated(param1:ModelUpdateEvent) : void
      {
         dispatchGetStoreItemsEvent();
      }
      
      public function getItemSpecificDIOs() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in domainInfo.getEventItems())
         {
            switch(_loc2_.itemType)
            {
               case EventItemType.MERCENARY.id:
                  _loc1_.push(domainInfo.getUnit(_loc2_.relatedId));
                  break;
               case EventItemType.CATAPULT.id:
                  _loc1_.push(domainInfo.getCatapult(_loc2_.relatedId));
            }
         }
         return _loc1_;
      }
      
      protected function dispatchGetStoreItemsEvent() : void
      {
         dispatch(new GetStoreItemsEvent("getStoreItems",StoreItemCategory.EVENT));
      }
      
      private function checkRendererValidityForClickedButton(param1:MPButton) : MobileEventStoreItemViewRenderer
      {
         var _loc2_:MobileEventStoreItemViewRenderer = null;
         if(param1 && param1.parent && param1.parent.parent && param1.parent.parent is MobileEventStoreItemViewRenderer)
         {
            _loc2_ = param1.parent.parent as MobileEventStoreItemViewRenderer;
            if(_loc2_.itemView)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

