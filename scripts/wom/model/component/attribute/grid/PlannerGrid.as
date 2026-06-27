package wom.model.component.attribute.grid
{
   import peak.cuckoo.core.Attribute;
   import wom.model.component.attribute.data.PlannerDecorationData;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   import wom.model.game.CityStatusInfo;
   
   public class PlannerGrid extends Attribute
   {
      
      public static const TYPE_ID:String = "PlannerGrid";
      
      public var grid:Array;
      
      public var city:CityStatusInfo;
      
      public function PlannerGrid()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "PlannerGrid";
      }
      
      override public function init() : void
      {
         super.init();
         this.grid = [];
      }
      
      public function checkCollision(param1:PlannerBuilding) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(!checkInCity(param1))
         {
            return true;
         }
         var _loc3_:int = param1.position.point.x + param1.data.baseSize;
         var _loc4_:int = param1.data.baseSize + param1.position.point.y;
         _loc6_ = param1.position.point.x;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param1.position.point.y;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = (_loc6_ << 10) + _loc5_;
               if(grid[_loc2_] && grid[_loc2_] != 0)
               {
                  return true;
               }
               _loc5_++;
            }
            _loc6_++;
         }
         return false;
      }
      
      public function checkInCity(param1:PlannerBuilding) : Boolean
      {
         var _loc2_:int = param1.data is PlannerDecorationData ? 100 : 0;
         return param1.position.point.x >= (city.dimensions.numberOfColumns + _loc2_) / -2 && param1.position.point.x + param1.data.baseSize - 1 < (city.dimensions.numberOfColumns + _loc2_) / 2 && param1.position.point.y >= (city.dimensions.numberOfRows + _loc2_) / -2 && param1.position.point.y + param1.data.baseSize - 1 < (city.dimensions.numberOfRows + _loc2_) / 2;
      }
      
      public function markArea(param1:PlannerBuilding) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = param1.position.point.x + param1.data.baseSize;
         var _loc4_:int = param1.data.baseSize + param1.position.point.y;
         _loc6_ = param1.position.point.x;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param1.position.point.y;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = (_loc6_ << 10) + _loc5_;
               if(grid[_loc2_])
               {
                  grid[_loc2_]++;
               }
               else
               {
                  grid[_loc2_] = 1;
               }
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      public function unmarkArea(param1:PlannerBuilding) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.position.point.x + param1.data.baseSize;
         var _loc3_:int = param1.data.baseSize + param1.position.point.y;
         _loc5_ = param1.position.point.x;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = param1.position.point.y;
            while(_loc4_ < _loc3_)
            {
               grid[(_loc5_ << 10) + _loc4_]--;
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      public function checkPigeonHole(param1:PlannerBuilding) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(!checkInCity(param1))
         {
            return true;
         }
         var _loc3_:int = param1.position.point.x + param1.data.baseSize;
         var _loc4_:int = param1.data.baseSize + param1.position.point.y;
         _loc6_ = param1.position.point.x;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param1.position.point.y;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = (_loc6_ << 10) + _loc5_;
               if(grid[_loc2_] > 1)
               {
                  return true;
               }
               _loc5_++;
            }
            _loc6_++;
         }
         return false;
      }
   }
}

