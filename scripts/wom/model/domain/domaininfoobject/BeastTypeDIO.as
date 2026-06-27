package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class BeastTypeDIO extends GenericUnitTypeDIO
   {
      
      private var _prerequisite:PrerequisiteDIO;
      
      private var _damagePerSecondsPerLevel:Vector.<int>;
      
      private var _healingTimesPerLevel:Vector.<int>;
      
      private var _healingCostTimesPerLevel:Vector.<int>;
      
      private var _buffsPerLevel:Vector.<int>;
      
      private var _trainingCostsPerLevel:Vector.<Vector.<UnitTypeAmountDTO>>;
      
      private var _trainingGoldCostsPerLevel:Vector.<int>;
      
      private var _levelUpGoldCostsPerLevel:Vector.<int>;
      
      private var _numberOfTrainingsToLevelUpPerLevel:Vector.<int>;
      
      private var _preTrainingDurationInSecs:int;
      
      private var _waitTrainingDurationInSecs:int;
      
      private var _maxBonusStages:int;
      
      private var _speedsPerStage:Vector.<Number>;
      
      private var _healthPointsPerStage:Vector.<int>;
      
      private var _damagePointsPerStage:Vector.<int>;
      
      private var _damagePerSecondsPerStage:Vector.<int>;
      
      private var _rangesPerStage:Vector.<int>;
      
      private var _buffsPerStage:Vector.<int>;
      
      private var _trainingCostsPerStage:Vector.<Vector.<UnitTypeAmountDTO>>;
      
      private var _trainingGoldCostsPerStage:Vector.<int>;
      
      private var _levelUpGoldCostsPerStage:Vector.<int>;
      
      private var _animationSortPointsPerStage:Vector.<Point>;
      
      private var _favouriteTargetsForMaxLevel:Vector.<int>;
      
      private var _unlocked:Boolean;
      
      private var _selectViewScale:Number;
      
      private var _selectViewOffset:Point;
      
      public function BeastTypeDIO(param1:int, param2:Vector.<int>, param3:PrerequisiteDIO, param4:Vector.<int>, param5:Vector.<int>, param6:Vector.<int>, param7:Vector.<int>, param8:Number, param9:Vector.<int>, param10:Vector.<Number>, param11:Vector.<Number>, param12:Vector.<int>, param13:Vector.<int>, param14:Vector.<Vector.<UnitTypeAmountDTO>>, param15:Vector.<int>, param16:Vector.<int>, param17:Vector.<int>, param18:int, param19:int, param20:int, param21:Vector.<Number>, param22:Vector.<int>, param23:Vector.<int>, param24:Vector.<int>, param25:Vector.<int>, param26:Vector.<int>, param27:Vector.<Vector.<UnitTypeAmountDTO>>, param28:Vector.<int>, param29:Vector.<int>, param30:int, param31:Dictionary, param32:String, param33:int, param34:int, param35:Boolean, param36:Vector.<Point>, param37:Boolean, param38:Boolean, param39:Boolean, param40:Vector.<int>, param41:Boolean, param42:Number, param43:Point, param44:String, param45:Boolean, param46:String)
      {
         super(param1,false,param2,param10,param11,param12,param13,param30,param31,param32,new Point(),param33,param34,param35,param7,param8,param37,param38,param39,param44,param45,param46);
         _prerequisite = param3;
         _damagePerSecondsPerLevel = param4;
         _healingTimesPerLevel = param5;
         _healingCostTimesPerLevel = param6;
         _buffsPerLevel = param9;
         _trainingCostsPerLevel = param14;
         _trainingGoldCostsPerLevel = param15;
         _levelUpGoldCostsPerLevel = param16;
         _numberOfTrainingsToLevelUpPerLevel = param17;
         _preTrainingDurationInSecs = param18;
         _waitTrainingDurationInSecs = param19;
         _maxBonusStages = param20;
         _speedsPerStage = param21;
         _healthPointsPerStage = param22;
         _damagePointsPerStage = param23;
         _damagePerSecondsPerStage = param24;
         _rangesPerStage = param25;
         _buffsPerStage = param26;
         _trainingCostsPerStage = param27;
         _trainingGoldCostsPerStage = param28;
         _levelUpGoldCostsPerStage = param29;
         _animationSortPointsPerStage = param36;
         _favouriteTargetsForMaxLevel = param40;
         _unlocked = param41;
         _selectViewScale = param42;
         _selectViewOffset = param43;
      }
      
      public function get prerequisite() : PrerequisiteDIO
      {
         return _prerequisite;
      }
      
      public function get damagePerSecondsPerLevel() : Vector.<int>
      {
         return _damagePerSecondsPerLevel;
      }
      
      public function get healingTimesPerLevel() : Vector.<int>
      {
         return _healingTimesPerLevel;
      }
      
      public function get buffsPerLevel() : Vector.<int>
      {
         return _buffsPerLevel;
      }
      
      public function get trainingCostsPerLevel() : Vector.<Vector.<UnitTypeAmountDTO>>
      {
         return _trainingCostsPerLevel;
      }
      
      public function get trainingGoldCostsPerLevel() : Vector.<int>
      {
         return _trainingGoldCostsPerLevel;
      }
      
      public function get levelUpGoldCostsPerLevel() : Vector.<int>
      {
         return _levelUpGoldCostsPerLevel;
      }
      
      public function get numberOfTrainingsToLevelUpPerLevel() : Vector.<int>
      {
         return _numberOfTrainingsToLevelUpPerLevel;
      }
      
      public function get preTrainingDurationInSecs() : int
      {
         return _preTrainingDurationInSecs;
      }
      
      public function get waitTrainingDurationInSecs() : int
      {
         return _waitTrainingDurationInSecs;
      }
      
      public function get maxBonusStages() : int
      {
         return _maxBonusStages;
      }
      
      public function get speedsPerStage() : Vector.<Number>
      {
         return _speedsPerStage;
      }
      
      public function get healthPointsPerStage() : Vector.<int>
      {
         return _healthPointsPerStage;
      }
      
      public function get damagePointsPerStage() : Vector.<int>
      {
         return _damagePointsPerStage;
      }
      
      public function get damagePerSecondsPerStage() : Vector.<int>
      {
         return _damagePerSecondsPerStage;
      }
      
      public function get rangesPerStage() : Vector.<int>
      {
         return _rangesPerStage;
      }
      
      public function get buffsPerStage() : Vector.<int>
      {
         return _buffsPerStage;
      }
      
      public function get trainingCostsPerStage() : Vector.<Vector.<UnitTypeAmountDTO>>
      {
         return _trainingCostsPerStage;
      }
      
      public function get trainingGoldCostsPerStage() : Vector.<int>
      {
         return _trainingGoldCostsPerStage;
      }
      
      public function get levelUpGoldCostsPerStage() : Vector.<int>
      {
         return _levelUpGoldCostsPerStage;
      }
      
      public function get animationSortPointsPerStage() : Vector.<Point>
      {
         return _animationSortPointsPerStage;
      }
      
      public function stageSpeedInYardUnit(param1:int) : Number
      {
         return _speedsPerStage[param1 - 1];
      }
      
      public function stageDamage(param1:int) : Number
      {
         return _damagePointsPerStage[param1 - 1];
      }
      
      public function get healingCostTimesPerLevel() : Vector.<int>
      {
         return _healingCostTimesPerLevel;
      }
      
      public function get favouriteTargetsForMaxLevel() : Vector.<int>
      {
         return _favouriteTargetsForMaxLevel;
      }
      
      public function get unlocked() : Boolean
      {
         return _unlocked;
      }
      
      public function set unlocked(param1:Boolean) : void
      {
         _unlocked = param1;
      }
      
      public function get selectViewScale() : Number
      {
         return _selectViewScale;
      }
      
      public function get selectViewOffset() : Point
      {
         return _selectViewOffset;
      }
   }
}

