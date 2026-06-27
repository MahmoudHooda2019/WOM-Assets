package wom.model.game.store
{
   public class StoreItemCategory
   {
      
      public static const CONSTRUCTION:StoreItemCategory = new StoreItemCategory(0,"Construction");
      
      public static const RESOURCE:StoreItemCategory = new StoreItemCategory(1,"Resource");
      
      public static const SPEEDUPS:StoreItemCategory = new StoreItemCategory(2,"Speedups");
      
      public static const COMBAT:StoreItemCategory = new StoreItemCategory(3,"Combat");
      
      public static const BUILDING_SPEEDUPS:StoreItemCategory = new StoreItemCategory(4,"Hidden");
      
      public static const EVENT:StoreItemCategory = new StoreItemCategory(5,"Event");
      
      public static const storeItemCategories:Array = [CONSTRUCTION,RESOURCE,SPEEDUPS,COMBAT,BUILDING_SPEEDUPS];
      
      private var _index:int;
      
      private var _name:String;
      
      public function StoreItemCategory(param1:int, param2:String)
      {
         super();
         this._index = param1;
         this._name = param2;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

