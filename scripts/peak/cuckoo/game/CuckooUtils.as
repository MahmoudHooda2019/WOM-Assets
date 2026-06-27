package peak.cuckoo.game
{
   import flash.geom.Point;
   
   public class CuckooUtils
   {
      
      public function CuckooUtils()
      {
         super();
      }
      
      public static function pointInPolygon(param1:Point, param2:Vector.<Point>) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:int = param2.length - 1;
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_].y < param1.y && param2[_loc4_].y >= param1.y || param2[_loc4_].y < param1.y && param2[_loc5_].y >= param1.y)
            {
               if(param2[_loc5_].x + (param1.y - param2[_loc5_].y) / (param2[_loc4_].y - param2[_loc5_].y) * (param2[_loc4_].x - param2[_loc5_].x) < param1.x)
               {
                  _loc3_ = !_loc3_;
               }
            }
            _loc4_ = _loc5_;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function coordInPolygon(param1:Number, param2:Number, param3:Vector.<Point>) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:int = param3.length - 1;
         var _loc4_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < param3.length)
         {
            if(param3[_loc6_].y < param2 && param3[_loc5_].y >= param2 || param3[_loc5_].y < param2 && param3[_loc6_].y >= param2)
            {
               if(param3[_loc6_].x + (param2 - param3[_loc6_].y) / (param3[_loc5_].y - param3[_loc6_].y) * (param3[_loc5_].x - param3[_loc6_].x) < param1)
               {
                  _loc4_ = !_loc4_;
               }
            }
            _loc5_ = _loc6_;
            _loc6_++;
         }
         return _loc4_;
      }
   }
}

