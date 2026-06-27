package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.inventory.InventoryItemCategory;
   
   public class InventoryPageReadyEvent extends PageReadyEvent
   {
      
      private var _inventoryItemCategory:InventoryItemCategory;
      
      public function InventoryPageReadyEvent(param1:String, param2:int, param3:int, param4:Vector.<*>, param5:InventoryItemCategory)
      {
         super(param1,param2,param3,param4);
         this._inventoryItemCategory = param5;
      }
      
      override public function clone() : Event
      {
         return new InventoryPageReadyEvent(type,pageNumber,totalItemCount,items,inventoryItemCategory);
      }
      
      public function get inventoryItemCategory() : InventoryItemCategory
      {
         return _inventoryItemCategory;
      }
   }
}

