package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class GenericUnitTypeDIO
   {
      
      private var _id:int;
      
      private var _targetsAnything:Boolean;
      
      private var _favouriteTargets:Vector.<int>;
      
      private var _speedsPerLevel:Vector.<Number>;
      
      private var _speedsInYardUnitPerLevel:Vector.<Number>;
      
      private var _healthPointsPerLevel:Vector.<int>;
      
      private var _damagePointsPerLevel:Vector.<int>;
      
      private var _maxLevels:int;
      
      private var _splashRange:Number;
      
      private var _rangesPerLevel:Vector.<int>;
      
      private var _specificInfo:Dictionary;
      
      private var _assetName:String;
      
      private var _animationSortPoint:Point;
      
      private var _movementAnimationSpeed:int;
      
      private var _attackAnimationSpeed:int;
      
      private var _flying:Boolean;
      
      private var _underground:Boolean;
      
      private var _healer:Boolean;
      
      private var _event:Boolean;
      
      private var _particleAsset:String;
      
      private var _particleRotate:Boolean;
      
      private var _particleSound:String;
      
      public function GenericUnitTypeDIO(param1:int, param2:Boolean, param3:Vector.<int>, param4:Vector.<Number>, param5:Vector.<Number>, param6:Vector.<int>, param7:Vector.<int>, param8:int, param9:Dictionary, param10:String, param11:Point, param12:int, param13:int, param14:Boolean, param15:Vector.<int>, param16:Number, param17:Boolean, param18:Boolean, param19:Boolean, param20:String, param21:Boolean, param22:String)
      {
         super();
         _id = param1;
         _targetsAnything = param2;
         _favouriteTargets = param3;
         _speedsPerLevel = param4;
         _speedsInYardUnitPerLevel = param5;
         _healthPointsPerLevel = param6;
         _damagePointsPerLevel = param7;
         _maxLevels = param8;
         _specificInfo = param9;
         _assetName = param10;
         _animationSortPoint = param11;
         _movementAnimationSpeed = param12;
         _attackAnimationSpeed = param13;
         _flying = param14;
         _underground = param17;
         _healer = param18;
         _rangesPerLevel = param15;
         _splashRange = param16;
         _event = param19;
         _particleAsset = param20;
         _particleRotate = param21;
         _particleSound = param22;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get targetsAnything() : Boolean
      {
         return _targetsAnything;
      }
      
      public function get favouriteTargets() : Vector.<int>
      {
         return _favouriteTargets;
      }
      
      public function get maxLevels() : int
      {
         return _maxLevels;
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
      
      public function get attackAnimationSpeed() : int
      {
         return _attackAnimationSpeed;
      }
      
      public function get flying() : Boolean
      {
         return _flying;
      }
      
      public function get underground() : Boolean
      {
         return _underground;
      }
      
      public function get healthPointsPerLevel() : Vector.<int>
      {
         return _healthPointsPerLevel;
      }
      
      public function get healer() : Boolean
      {
         return _healer;
      }
      
      public function get event() : Boolean
      {
         return _event;
      }
      
      public function range(param1:int) : int
      {
         return _rangesPerLevel[param1];
      }
      
      public function get splashRange() : Number
      {
         return _splashRange;
      }
      
      public function speed(param1:int, param2:Number = 1) : Number
      {
         return _speedsPerLevel[param1] * param2;
      }
      
      public function speedInYardUnit(param1:int, param2:Number = 1) : Number
      {
         return _speedsInYardUnitPerLevel[param1] * param2;
      }
      
      public function damage(param1:int, param2:Number = 1) : Number
      {
         return _damagePointsPerLevel[param1] * param2;
      }
      
      public function get specificInfo() : Dictionary
      {
         return _specificInfo;
      }
      
      public function get particleAsset() : String
      {
         return _particleAsset;
      }
      
      public function get particleRotate() : Boolean
      {
         return _particleRotate;
      }
      
      public function get particleSound() : String
      {
         return _particleSound;
      }
   }
}

