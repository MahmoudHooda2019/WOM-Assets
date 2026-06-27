package wom.model.game.building
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FortificationType
   {
      
      private static const assetPrefix:String = "Fortification";
      
      public static const FRONT:String = "Front";
      
      public static const BACK:String = "Back";
      
      public static const UNKNOWN:FortificationType = new FortificationType("Unknown",0,"Front",new Point());
      
      public static const fortificationTypes:Dictionary = new Dictionary();
      
      private var _size:String;
      
      private var _stage:int;
      
      private var _direction:String;
      
      private var _offset:Point;
      
      public function FortificationType(param1:String, param2:int, param3:String, param4:Point)
      {
         super();
         _size = param1;
         _stage = param2;
         _direction = param3;
         _offset = param4;
      }
      
      public static function addFortificationType(param1:String, param2:int, param3:String, param4:Point) : void
      {
         var _loc5_:FortificationType = new FortificationType(param1,param2,param3,param4);
         if(!(param1 in fortificationTypes))
         {
            fortificationTypes[param1] = new Dictionary();
         }
         if(!(param2 in fortificationTypes[param1]))
         {
            fortificationTypes[param1][param2] = new Dictionary();
         }
         if(!(param3 in fortificationTypes[param1][param2]))
         {
            fortificationTypes[param1][param2][param3] = new Dictionary();
         }
         fortificationTypes[param1][param2][param3] = _loc5_;
      }
      
      public static function determineFortificationType(param1:String, param2:int, param3:String) : FortificationType
      {
         if(param1 in fortificationTypes && param2 in fortificationTypes[param1] && param3 in fortificationTypes[param1][param2])
         {
            return fortificationTypes[param1][param2][param3];
         }
         return UNKNOWN;
      }
      
      public function get asset() : String
      {
         return "Fortification" + _size + "S" + _stage + _direction;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
   }
}

