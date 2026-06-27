package wom.model.game.unit
{
   public class UnitTypeInfo
   {
      
      public static const BEDOUIN_BRUTE:int = 10;
      
      public static const JANISSARY:int = 11;
      
      public static const NIGHT_RIDER:int = 12;
      
      public static const PERSIAN_HASHISHIN:int = 13;
      
      public static const KHAMIKAZEE:int = 14;
      
      public static const NUBIAN_GUARD:int = 15;
      
      public static const RAVAGER:int = 16;
      
      public static const PAINBLOWER:int = 17;
      
      public static const SNEAK_PEAK:int = 18;
      
      public static const MONGOLIAN_GARGANTUAN:int = 19;
      
      public static const PHARAOH_WARRIOR:int = 20;
      
      public static const GENTLE_HEALER:int = 24;
      
      public static const HEZARFEN:int = 23;
      
      public static const PERSIAN_SAPPER:int = 22;
      
      public static const ROCK_N_GAUL:int = 21;
      
      public static const DRAGONFLY:int = 25;
      
      public static const MIGHTOSOUR:int = 26;
      
      public static const BEARWOLF:int = 27;
      
      public static const WOMKONG:int = 33;
      
      public static const SAMURAI_TEAM:int = 28;
      
      public static const SIEGE_TOWER:int = 29;
      
      public static const CYCLOP:int = 30;
      
      public static const LONGBOWMAN:int = 31;
      
      public static const WOLFPACK:int = 32;
      
      public static const ACID_TOWER:int = 34;
      
      private var _unitTypeId:int;
      
      private var _currentLevel:int;
      
      private var _recruited:Boolean;
      
      private var _recruitable:Boolean;
      
      private var _upgradable:Boolean;
      
      private var _currentlyTraining:Boolean;
      
      private var _currentlyRecruiting:Boolean;
      
      private var _durationRemaining:Number;
      
      private var _originalDuration:Number;
      
      private var _jobCreationTime:Number;
      
      public var masteryLevel:int = 0;
      
      public function UnitTypeInfo(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Number, param9:Number, param10:Number)
      {
         super();
         _unitTypeId = param1;
         _currentLevel = param2;
         _recruited = param3;
         _recruitable = param4;
         _upgradable = param5;
         _currentlyTraining = param6;
         _currentlyRecruiting = param7;
         _durationRemaining = param8;
         _originalDuration = param9;
         _jobCreationTime = param10;
      }
      
      public static function isBeast(param1:int) : Boolean
      {
         return param1 == 25 || param1 == 26 || param1 == 27 || param1 == 33;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get currentLevel() : int
      {
         return _currentLevel;
      }
      
      public function set currentLevel(param1:int) : void
      {
         _currentLevel = param1;
      }
      
      public function get recruited() : Boolean
      {
         return _recruited;
      }
      
      public function set recruited(param1:Boolean) : void
      {
         _recruited = param1;
      }
      
      public function get recruitable() : Boolean
      {
         return _recruitable;
      }
      
      public function set recruitable(param1:Boolean) : void
      {
         _recruitable = param1;
      }
      
      public function get upgradable() : Boolean
      {
         return _upgradable;
      }
      
      public function set upgradable(param1:Boolean) : void
      {
         _upgradable = param1;
      }
      
      public function get currentlyTraining() : Boolean
      {
         return _currentlyTraining;
      }
      
      public function get currentlyRecruiting() : Boolean
      {
         return _currentlyRecruiting;
      }
      
      public function get durationRemaining() : Number
      {
         return _durationRemaining;
      }
      
      public function get originalDuration() : Number
      {
         return _originalDuration;
      }
      
      public function set currentlyTraining(param1:Boolean) : void
      {
         _currentlyTraining = param1;
      }
      
      public function set currentlyRecruiting(param1:Boolean) : void
      {
         _currentlyRecruiting = param1;
      }
      
      public function set durationRemaining(param1:Number) : void
      {
         _durationRemaining = param1;
      }
      
      public function set originalDuration(param1:Number) : void
      {
         _originalDuration = param1;
      }
      
      public function get jobCreationTime() : Number
      {
         return _jobCreationTime;
      }
      
      public function set jobCreationTime(param1:Number) : void
      {
         _jobCreationTime = param1;
      }
   }
}

