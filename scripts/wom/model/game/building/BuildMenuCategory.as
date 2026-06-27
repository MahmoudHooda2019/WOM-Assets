package wom.model.game.building
{
   public class BuildMenuCategory
   {
      
      public static const UNKNOWN:BuildMenuCategory = new BuildMenuCategory(0,"unknown");
      
      public static const RESOURCE:BuildMenuCategory = new BuildMenuCategory(1,"resource");
      
      public static const FUNCTIONAL:BuildMenuCategory = new BuildMenuCategory(2,"functional");
      
      public static const DEFENSIVE:BuildMenuCategory = new BuildMenuCategory(3,"defensive");
      
      public static const DECORATORS:BuildMenuCategory = new BuildMenuCategory(4,"decorators");
      
      public static const buildMenuCategories:Array = [UNKNOWN,RESOURCE,FUNCTIONAL,DEFENSIVE,DECORATORS];
      
      private var _id:int;
      
      private var _name:String;
      
      public function BuildMenuCategory(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public static function getCategory(param1:int) : BuildMenuCategory
      {
         return buildMenuCategories[param1];
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

