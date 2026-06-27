package wom.model.game.beast
{
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   
   public class BeastInfo extends UnitInfo
   {
      
      public static const DRAGONFLY:int = 25;
      
      public static const MIGHTOSOUR:int = 26;
      
      public static const BEARWOLF:int = 27;
      
      public static const WOMKONG:int = 33;
      
      private var _numberOfTrainingsLeftToNextLevel:int;
      
      private var _jobScheduler:BeastJobScheduler;
      
      private var _level:int;
      
      private var _starved:Boolean;
      
      private var _bonusStage:int;
      
      private var _remainderHealthPoints:Number;
      
      public function BeastInfo(param1:int, param2:UnitStatusType, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:int)
      {
         super(param1,param2,param3,param4,param5,1,1,1);
         _numberOfTrainingsLeftToNextLevel = param6;
         _level = param7;
         _starved = param8;
         _bonusStage = param9;
         _remainderHealthPoints = 0;
      }
      
      public function get remainderHealthPoints() : Number
      {
         return _remainderHealthPoints;
      }
      
      public function set remainderHealthPoints(param1:Number) : void
      {
         _remainderHealthPoints = param1;
      }
      
      public function get numberOfTrainingsLeftToNextLevel() : int
      {
         return _numberOfTrainingsLeftToNextLevel;
      }
      
      public function get jobScheduler() : BeastJobScheduler
      {
         return _jobScheduler;
      }
      
      public function set jobScheduler(param1:BeastJobScheduler) : void
      {
         _jobScheduler = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get starved() : Boolean
      {
         return _starved;
      }
      
      public function get bonusStage() : int
      {
         return _bonusStage;
      }
      
      public function set bonusStage(param1:int) : void
      {
         _bonusStage = param1;
      }
   }
}

