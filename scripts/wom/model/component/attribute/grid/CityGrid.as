package wom.model.component.attribute.grid
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.dto.WeightNode;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.helper.RowColumnPair;
   
   public class CityGrid extends Attribute
   {
      
      public static const TYPE_ID:String = "CityGrid";
      
      public var dimension:RowColumnPair;
      
      public var projectedBoundLeft:Point;
      
      public var projectedBoundBottom:Point;
      
      public var projectedBoundRight:Point;
      
      public var projectedBoundTop:Point;
      
      private var ownerRoot:WomGameRoot;
      
      public var grid:Array;
      
      public var weightGrid:WeightGrid;
      
      public function CityGrid(param1:RowColumnPair)
      {
         super();
         this.dimension = param1;
      }
      
      override public function get typeId() : String
      {
         return "CityGrid";
      }
      
      override public function init() : void
      {
         super.init();
         grid = [];
         ownerRoot = owner.root as WomGameRoot;
         weightGrid = ownerRoot.weightGrid;
      }
      
      public function markBuilding(param1:int, param2:int, param3:BuildingData) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         if((ownerRoot.userInfo.gameMode == GameModeType.ATTACK || ownerRoot.userInfo.gameMode == GameModeType.VISIT) && param3.buildingInfo.isTrap)
         {
            return;
         }
         var _loc6_:int = param3.buildingTypeDIO.baseSize;
         markConstructable(param1,param2,_loc6_,param3.owner);
         param1 += param3.pathOutMargin;
         param2 += param3.pathOutMargin;
         var _loc4_:int = _loc6_ - param3.pathOutMargin * 2;
         var _loc5_:int = _loc6_ - param3.pathOutMargin * 2;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               (weightGrid.grid[(param1 + _loc8_ << 10) + (param2 + _loc7_)] as WeightNode).weight += param3.pathWeightGrid[_loc8_][_loc7_];
               _loc7_++;
            }
            _loc8_++;
         }
      }
      
      public function markConstructable(param1:int, param2:int, param3:int, param4:Entity) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         if((ownerRoot.userInfo.gameMode == GameModeType.ATTACK || ownerRoot.userInfo.gameMode == GameModeType.VISIT) && param4 is Decoration)
         {
            return;
         }
         var _loc5_:int = param1 + param3;
         var _loc6_:int = param2 + param3;
         _loc8_ = param1;
         while(_loc8_ < _loc5_)
         {
            _loc7_ = param2;
            while(_loc7_ < _loc6_)
            {
               grid[(_loc8_ << 10) + _loc7_] = param4;
               _loc7_++;
            }
            _loc8_++;
         }
      }
      
      public function unmarkBuilding(param1:int, param2:int, param3:BuildingData) : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = param3.buildingTypeDIO.baseSize;
         unmarkConstructable(param1,param2,_loc6_);
         param1 += param3.pathOutMargin;
         param2 += param3.pathOutMargin;
         var _loc4_:int = _loc6_ - param3.pathOutMargin * 2;
         var _loc5_:int = _loc6_ - param3.pathOutMargin * 2;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               (weightGrid.grid[(param1 + _loc8_ << 10) + (param2 + _loc7_)] as WeightNode).weight -= param3.pathWeightGrid[_loc8_][_loc7_];
               _loc7_++;
            }
            _loc8_++;
         }
      }
      
      public function unmarkConstructable(param1:int, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = param1 + param3;
         var _loc5_:int = param2 + param3;
         _loc7_ = param1;
         while(_loc7_ < _loc4_)
         {
            _loc6_ = param2;
            while(_loc6_ < _loc5_)
            {
               grid[(_loc7_ << 10) + _loc6_] = null;
               _loc6_++;
            }
            _loc7_++;
         }
      }
      
      public function checkCollision(param1:Rectangle, param2:int = 0) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(!checkInCity(param1,param2))
         {
            return true;
         }
         var _loc3_:int = param1.x + param1.width;
         var _loc4_:int = param1.height + param1.y;
         _loc6_ = param1.x;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param1.y;
            while(_loc5_ < _loc4_)
            {
               if(grid[(_loc6_ << 10) + _loc5_])
               {
                  return true;
               }
               _loc5_++;
            }
            _loc6_++;
         }
         return false;
      }
      
      public function getAppropriatePositionForNewConstruct(param1:int) : Point
      {
         var _loc9_:int = 0;
         var _loc14_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc10_:int = 1;
         var _loc13_:Point = new Point();
         var _loc16_:Point = new Point(0,-_loc10_);
         var _loc15_:int = 0;
         var _loc11_:int = dimension.numberOfColumns + _loc15_;
         var _loc7_:int = dimension.numberOfRows + _loc15_;
         _loc11_ = int(_loc11_ % 2 == 0 ? _loc11_ + 1 : _loc11_);
         _loc7_ = int(_loc7_ % 2 == 0 ? _loc7_ + 1 : _loc7_);
         var _loc2_:int = Math.max(_loc11_,_loc7_);
         var _loc8_:int = _loc2_ * _loc2_;
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            if(_loc13_.x >= dimension.numberOfColumns / -2 && _loc13_.x + param1 - 1 < dimension.numberOfColumns / 2 && _loc13_.y >= dimension.numberOfRows / -2 && _loc13_.y + param1 - 1 < dimension.numberOfRows / 2)
            {
               _loc14_ = false;
               _loc3_ = _loc13_.x + param1;
               _loc4_ = _loc13_.y + param1;
               _loc5_ = _loc13_.x;
               while(_loc5_ < _loc3_ && !_loc14_)
               {
                  _loc6_ = _loc13_.y;
                  while(_loc6_ < _loc4_ && !_loc14_)
                  {
                     if(grid[(_loc5_ << 10) + _loc6_])
                     {
                        _loc14_ = true;
                     }
                     _loc6_++;
                  }
                  _loc5_++;
               }
               if(!_loc14_)
               {
                  return _loc13_;
               }
            }
            if(_loc13_.x == _loc13_.y || _loc13_.x < 0 && _loc13_.x == -_loc13_.y || _loc13_.x > 0 && _loc13_.x == 1 - _loc13_.y)
            {
               _loc12_ = _loc16_.x;
               _loc16_.x = -_loc16_.y;
               _loc16_.y = _loc12_;
            }
            _loc13_.x += _loc16_.x;
            _loc13_.y += _loc16_.y;
            _loc9_++;
         }
         return _loc13_;
      }
      
      public function checkInCity(param1:Rectangle, param2:int = 0) : Boolean
      {
         return param1.x >= dimension.numberOfColumns / -2 - param2 && param1.x + param1.width - 1 < dimension.numberOfColumns / 2 + param2 && param1.y >= dimension.numberOfRows / -2 - param2 && param1.y + param1.height - 1 < dimension.numberOfRows / 2 + param2;
      }
      
      public function update(param1:RowColumnPair) : void
      {
         if(this.dimension.numberOfColumns != param1.numberOfColumns || this.dimension.numberOfRows != param1.numberOfRows)
         {
            this.dimension.copyFrom(param1);
            if(ownerRoot.weightGrid)
            {
               ownerRoot.weightGrid.updateDimension(param1.numberOfColumns >> 1,param1.numberOfRows >> 1);
            }
         }
      }
   }
}

