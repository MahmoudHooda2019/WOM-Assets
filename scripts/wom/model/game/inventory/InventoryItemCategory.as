package wom.model.game.inventory
{
   public class InventoryItemCategory
   {
      
      public static const ALL:InventoryItemCategory = new InventoryItemCategory(0,0,"all");
      
      public static const RESOURCE:InventoryItemCategory = new InventoryItemCategory(1,1,"resource");
      
      public static const PARTS:InventoryItemCategory = new InventoryItemCategory(3,2,"parts");
      
      public static const TAVERN:InventoryItemCategory = new InventoryItemCategory(4,3,"tavern");
      
      public static const inventoryItemCategories:Array = [ALL,RESOURCE,PARTS,TAVERN];
      
      public static const resourceInventoryItems:Array = [101,102,103,104];
      
      private var _id:int;
      
      private var _tabIndex:int;
      
      private var _name:String;
      
      public function InventoryItemCategory(param1:int, param2:int, param3:String)
      {
         super();
         _id = param1;
         _tabIndex = param2;
         _name = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get tabIndex() : int
      {
         return _tabIndex;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

