package wom.model.component.attribute.grid
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.dto.IntBounds;
   import peak.cuckoo.game.dto.WeightNode;
   import wom.model.component.WomGameRoot;
   import wom.model.game.helper.RowColumnPair;
   
   public class WeightGrid extends Attribute
   {
      
      public static const TYPE_ID:String = "WeightGrid";
      
      public static const EMPTY:int = 2;
      
      public static const GARDEN:int = 5;
      
      public static const WALK_LIMIT:int = 7;
      
      public static const OBSTACLE:int = 40;
      
      public static const BORDER:Number = Infinity;
      
      public static const edge:uint = 50;
      
      public var bounds:IntBounds;
      
      public var grid:Array;
      
      private var xMax:uint = 0;
      
      private var yMax:uint;
      
      private var dimension:RowColumnPair;
      
      public function WeightGrid()
      {
         super();
         bounds = new IntBounds();
         grid = [];
      }
      
      override public function get typeId() : String
      {
         return "WeightGrid";
      }
      
      override public function init() : void
      {
      }
      
      public function dimensionsLoaded() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         for(var _loc2_ in grid)
         {
            delete grid[_loc2_];
         }
         dimension = (owner.root as WomGameRoot).cityInfo.dimensions;
         xMax = dimension.numberOfColumns / 2 + 50;
         yMax = dimension.numberOfRows / 2 + 50;
         _loc3_ = -xMax;
         while(_loc3_ <= xMax)
         {
            _loc1_ = -yMax;
            while(_loc1_ < yMax)
            {
               grid[(_loc3_ << 10) + _loc1_] = new WeightNode(_loc3_,_loc1_,2);
               _loc1_++;
            }
            grid[(_loc3_ << 10) - yMax] = new WeightNode(_loc3_,-yMax,Infinity);
            grid[(_loc3_ << 10) + yMax] = new WeightNode(_loc3_,yMax,Infinity);
            _loc3_++;
         }
         _loc1_ = -yMax;
         while(_loc1_ <= yMax)
         {
            grid[(-xMax << 10) + _loc1_] = new WeightNode(-xMax,_loc1_,Infinity);
            grid[(xMax << 10) + _loc1_] = new WeightNode(xMax,_loc1_,Infinity);
            _loc1_++;
         }
         bounds.lowX = -xMax + 1;
         bounds.lowY = -yMax + 1;
         bounds.highX = xMax - 1;
         bounds.highY = yMax - 1;
      }
      
      public function updateDimension(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         param1 += 50;
         param2 += 50;
         _loc4_ = -param1;
         while(_loc4_ <= param1)
         {
            _loc3_ = -param2;
            while(_loc3_ < param2)
            {
               if(!grid[(_loc4_ << 10) + _loc3_] || grid[(_loc4_ << 10) + _loc3_] && grid[(_loc4_ << 10) + _loc3_].weight == Infinity)
               {
                  grid[(_loc4_ << 10) + _loc3_] = new WeightNode(_loc4_,_loc3_,2);
               }
               _loc3_++;
            }
            grid[(_loc4_ << 10) - param2] = new WeightNode(_loc4_,-param2,Infinity);
            grid[(_loc4_ << 10) + param2] = new WeightNode(_loc4_,param2,Infinity);
            _loc4_++;
         }
         _loc3_ = -param2;
         while(_loc3_ <= param2)
         {
            grid[(-param1 << 10) + _loc3_] = new WeightNode(-param1,_loc3_,Infinity);
            grid[(param1 << 10) + _loc3_] = new WeightNode(param1,_loc3_,Infinity);
            _loc3_++;
         }
         xMax = param1;
         yMax = param2;
         bounds.lowX = -xMax + 1;
         bounds.lowY = -yMax + 1;
         bounds.highX = xMax - 1;
         bounds.highY = yMax - 1;
      }
   }
}

