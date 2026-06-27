package wom.view.mediator.screen.windows.blacksmith
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventItemUtil2;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithEventItemRenderer;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithSelectEventItemPanel;
   
   public class MobileBlacksmithSelectEventItemPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileBlacksmithSelectEventItemPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var eventItemUtil2:EventItemUtil2;
      
      public function MobileBlacksmithSelectEventItemPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("eventItemsUpdated",onEventItemTypesUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.eventItemList,"rendererAdd",onRendererAdded,Event);
         view.fillEventItems(eventItemUtil2.getEventItems(),userInfo.unlockedEventItems);
         updateEventItemInfo(domainInfo.getEventItems()[0]);
      }
      
      private function onRendererAdded(param1:Event, param2:MobileBlacksmithEventItemRenderer) : void
      {
         eventMap.mapStarlingListener(param2.eventItemButton,"triggered",onEventItemSelected,Event);
      }
      
      private function onEventItemSelected(param1:Event) : void
      {
         var _loc2_:EventItemDIO = ((param1.target as MobileWomButton).parent as MobileBlacksmithEventItemRenderer).eventItemDIO;
         if(_loc2_)
         {
            updateEventItemInfo(_loc2_);
         }
      }
      
      private function onEventItemTypesUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateEventItems(eventItemUtil2.getEventItems(),userInfo.unlockedEventItems);
      }
      
      public function updateEventItemInfo(param1:EventItemDIO) : void
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc3_:UnitTypeInfo = null;
         view.eventItemInfoPanel.updateInfo(param1);
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               _loc2_ = domainInfo.getUnit(param1.relatedId);
               _loc3_ = city.unitTypes[_loc2_.id];
               view.updateUnitDetails(_loc2_,_loc3_,city.resourceAmounts);
               break;
            case EventItemType.CATAPULT.id:
               view.updateCatapultDetails(domainInfo.getCatapult(param1.relatedId),city.resourceAmounts);
         }
      }
   }
}

