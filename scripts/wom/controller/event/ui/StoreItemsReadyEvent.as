package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemInfo;
   
   public class StoreItemsReadyEvent extends Event
   {
      
      public static const STORE_ITEMS_READY:String = "storeItemsReady";
      
      private var _items:Vector.<StoreItemInfo>;
      
      private var _category:StoreItemCategory;
      
      public function StoreItemsReadyEvent(param1:String, param2:Vector.<StoreItemInfo>, param3:StoreItemCategory)
      {
         super(param1);
         _items = param2;
         _category = param3;
      }
      
      override public function clone() : Event
      {
         return new StoreItemsReadyEvent(type,_items,_category);
      }
      
      public function get items() : Vector.<StoreItemInfo>
      {
         return _items;
      }
      
      public function get category() : StoreItemCategory
      {
         return _category;
      }
   }
}

