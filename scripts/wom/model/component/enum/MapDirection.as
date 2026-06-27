package wom.model.component.enum
{
   public class MapDirection
   {
      
      public static const LEFT:MapDirection = new MapDirection(0,"Left");
      
      public static const TOP:MapDirection = new MapDirection(1,"Top");
      
      public static const RIGHT:MapDirection = new MapDirection(2,"Right");
      
      public static const BOTTOM:MapDirection = new MapDirection(3,"Bottom");
      
      private var _id:int;
      
      private var _name:String;
      
      public function MapDirection(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
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

