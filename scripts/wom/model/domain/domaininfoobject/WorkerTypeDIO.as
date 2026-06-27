package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   
   public class WorkerTypeDIO
   {
      
      public static const SPEED:Number = 0.2;
      
      public static const MAX_INSTANCE:int = 5;
      
      private var _assetName:String;
      
      private var _animationSortPoint:Point;
      
      private var _movementAnimationSpeed:int;
      
      private var _workAnimationSpeed:int;
      
      private var _baseCostPerInstance:Vector.<int>;
      
      private var _staffGoldReductionsPerInstance:Vector.<Vector.<int>>;
      
      public function WorkerTypeDIO(param1:String, param2:Point, param3:int, param4:int, param5:Vector.<int>, param6:Vector.<Vector.<int>>)
      {
         super();
         _assetName = param1;
         _animationSortPoint = param2;
         _movementAnimationSpeed = param3;
         _workAnimationSpeed = param4;
         _baseCostPerInstance = param5;
         _staffGoldReductionsPerInstance = param6;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get animationSortPoint() : Point
      {
         return _animationSortPoint;
      }
      
      public function get movementAnimationSpeed() : int
      {
         return _movementAnimationSpeed;
      }
      
      public function get workAnimationSpeed() : int
      {
         return _workAnimationSpeed;
      }
      
      public function get baseCostPerInstance() : Vector.<int>
      {
         return _baseCostPerInstance;
      }
      
      public function get staffGoldReductionsPerInstance() : Vector.<Vector.<int>>
      {
         return _staffGoldReductionsPerInstance;
      }
      
      public function calculateGoldToBuy(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         if(param1 >= _baseCostPerInstance.length)
         {
            return 0;
         }
         var _loc3_:int = _baseCostPerInstance[param1];
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc3_ -= _staffGoldReductionsPerInstance[param1][_loc4_];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

