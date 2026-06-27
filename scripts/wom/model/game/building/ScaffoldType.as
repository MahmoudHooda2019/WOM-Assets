package wom.model.game.building
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class ScaffoldType
   {
      
      private static const assetPrefix:String = "Scaffold";
      
      public static const FRONT:String = "Front";
      
      public static const BACK:String = "Back";
      
      public static const UNKNOWN:ScaffoldType = new ScaffoldType("Unknown","Front",new Point());
      
      public static const scaffoldTypes:Dictionary = new Dictionary();
      
      private var _size:String;
      
      private var _direction:String;
      
      private var _offset:Point;
      
      public function ScaffoldType(param1:String, param2:String, param3:Point)
      {
         super();
         _size = param1;
         _direction = param2;
         _offset = param3;
      }
      
      public static function addScaffoldType(param1:String, param2:String, param3:Point) : void
      {
         var _loc4_:ScaffoldType = new ScaffoldType(param1,param2,param3);
         if(!(param1 in scaffoldTypes))
         {
            scaffoldTypes[param1] = new Dictionary();
         }
         if(!(param2 in scaffoldTypes[param1]))
         {
            scaffoldTypes[param1][param2] = new Dictionary();
         }
         scaffoldTypes[param1][param2] = _loc4_;
      }
      
      public static function determineScaffoldType(param1:String, param2:String) : ScaffoldType
      {
         if(param1 in scaffoldTypes && param2 in scaffoldTypes[param1])
         {
            return scaffoldTypes[param1][param2];
         }
         return UNKNOWN;
      }
      
      public static function determineScaffoldTypeByBaseSize(param1:int, param2:String) : ScaffoldType
      {
         var _loc3_:String = param1 < 16 ? "Small" : (param1 > 26 ? "Large" : "Medium");
         return determineScaffoldType(_loc3_,param2);
      }
      
      public function get asset() : String
      {
         return "Scaffold" + _size + (_direction == "Front" ? "" : "Back");
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
   }
}

