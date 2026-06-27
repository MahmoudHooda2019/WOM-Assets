package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.store.StoreItemCategory;
   
   public class GetStoreItemsEvent extends Event
   {
      
      public static const GET_STORE_ITEMS:String = "getStoreItems";
      
      private var _category:StoreItemCategory;
      
      private var _instanceId:int;
      
      public function GetStoreItemsEvent(param1:String, param2:StoreItemCategory, param3:int = -1)
      {
         super(param1);
         _category = param2;
         _instanceId = param3;
      }
      
      override public function clone() : Event
      {
         return new GetStoreItemsEvent(type,_category,_instanceId);
      }
      
      public function get category() : StoreItemCategory
      {
         return _category;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

