package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.command.util.InventoryUtil;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.message.notification.InventoryUpdatedEventNotification;
   
   public class HandleInventoryUpdatedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleInventoryUpdatedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:InventoryUpdatedEventNotification = messageReceivedEvent.message as InventoryUpdatedEventNotification;
         var _loc2_:Vector.<InventoryItemDTO> = InventoryUtil.createItemsList(domainInfo,city,_loc3_.partAmounts,_loc3_.resourceGifts,_loc3_.unitGifts,_loc3_.decorationGifts);
         InventoryUtil.markNewlyAddedItems(userInfo.items,_loc2_);
         var _loc1_:int = int(userInfo.items ? userInfo.items.length : 0);
         userInfo.items = _loc2_;
         var _loc4_:int = int(userInfo.items ? userInfo.items.length : 0);
         userInfo.resourceGifts = _loc3_.resourceGifts;
         coreManager.manageIncompleteBuildingIndicators();
         dispatch(new ModelUpdateEvent("inventoryUpdated"));
         if(_loc1_ < _loc4_)
         {
            dispatch(new ModelUpdateEvent("inventoryItemAdded"));
         }
      }
   }
}

