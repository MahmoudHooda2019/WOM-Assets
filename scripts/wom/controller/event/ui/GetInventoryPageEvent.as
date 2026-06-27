package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.inventory.InventoryItemCategory;
   
   public class GetInventoryPageEvent extends GetPageEvent
   {
      
      private var _category:InventoryItemCategory;
      
      public function GetInventoryPageEvent(param1:String, param2:int, param3:int, param4:InventoryItemCategory)
      {
         super(param1,param2,param3);
         _category = param4;
      }
      
      override public function clone() : Event
      {
         return new GetInventoryPageEvent(type,pageNumber,itemCountPerPage,_category);
      }
      
      public function get category() : InventoryItemCategory
      {
         return _category;
      }
   }
}

