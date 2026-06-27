package wom.model.dto
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class MapMemberInfo
   {
      
      public static const INVALID_RELATION:int = 0;
      
      public static const NEUTRAL:int = 1;
      
      public static const HOSTILE:int = 2;
      
      public static const LEVEL_TOO_LOW:int = 6;
      
      public static const UNDER_PROTECTION:int = 7;
      
      public static const WIPED_OUT:int = 8;
      
      public static const ALLY:int = 9;
      
      public static const LEVEL_TOO_HIGH:int = 10;
      
      private var _profile:Profile;
      
      private var _profileAccordingToTutorial:Profile;
      
      private var _visibleName:String;
      
      private var _position:int;
      
      private var _level:int;
      
      private var _battlePoints:int;
      
      private var _online:Boolean;
      
      private var _numberOfWins:int;
      
      private var _numberOfBattles:int;
      
      private var _playerRelation:int;
      
      private var _underProtection:Boolean;
      
      private var _mandatoryTutorialCompleted:Boolean;
      
      private var _npcClan:String;
      
      private var _truceExpirationRemainingTime:Number = 0;
      
      private var _truceRejectionRemainingTime:Number = 0;
      
      private var _isCurrentUser:Boolean = false;
      
      private var _completelyDestroyed:Boolean = false;
      
      private var _alliance:AllianceSummaryInfo;
      
      private var _isFriend:Boolean;
      
      private var _isAllianceEnemy:Boolean;
      
      private var _isRevanchist:Boolean;
      
      private var _canBeRetaliated:Boolean;
      
      private var _isEventNpc:Boolean;
      
      public function MapMemberInfo(param1:Profile, param2:int, param3:int, param4:int, param5:Boolean, param6:int, param7:int, param8:int, param9:Boolean, param10:Boolean, param11:Boolean, param12:AllianceSummaryInfo, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean)
      {
         super();
         _profile = param1;
         _position = param2;
         _level = param3;
         _battlePoints = param4;
         _online = param5;
         _numberOfBattles = param7;
         _playerRelation = param8;
         _underProtection = param9;
         _mandatoryTutorialCompleted = param1.isNpc ? true : param10;
         _completelyDestroyed = param11;
         _visibleName = param1.gameId;
         _alliance = param12;
         _isFriend = param13;
         _isAllianceEnemy = param14;
         _isRevanchist = param15;
         _canBeRetaliated = param16;
         _numberOfWins = param6;
         _isEventNpc = param17;
         _npcClan = param1.npcClan;
      }
      
      public function isAttackable() : Boolean
      {
         return _isEventNpc || !_online && _playerRelation != 9 && _playerRelation != 6 && _playerRelation != 10 && _playerRelation != 7 && !_completelyDestroyed;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get visibleName() : String
      {
         return _visibleName;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function get numberOfBattles() : int
      {
         return _numberOfBattles;
      }
      
      public function get playerRelation() : int
      {
         return _playerRelation;
      }
      
      public function get underProtection() : Boolean
      {
         return _underProtection;
      }
      
      public function get mandatoryTutorialCompleted() : Boolean
      {
         return _mandatoryTutorialCompleted;
      }
      
      public function get npcClan() : String
      {
         return _npcClan;
      }
      
      public function get truceExpirationRemainingTime() : Number
      {
         return _truceExpirationRemainingTime;
      }
      
      public function get truceRejectionRemainingTime() : Number
      {
         return _truceRejectionRemainingTime;
      }
      
      public function get isCurrentUser() : Boolean
      {
         return _isCurrentUser;
      }
      
      public function get completelyDestroyed() : Boolean
      {
         return _completelyDestroyed;
      }
      
      public function set playerRelation(param1:int) : void
      {
         _playerRelation = param1;
      }
      
      public function set isCurrentUser(param1:Boolean) : void
      {
         _isCurrentUser = param1;
      }
      
      public function set truceExpirationRemainingTime(param1:Number) : void
      {
         _truceExpirationRemainingTime = param1;
      }
      
      public function set truceRejectionRemainingTime(param1:Number) : void
      {
         _truceRejectionRemainingTime = param1;
      }
      
      public function set visibleName(param1:String) : void
      {
         _visibleName = param1;
      }
      
      public function get alliance() : AllianceSummaryInfo
      {
         return _alliance;
      }
      
      public function get battlePoints() : int
      {
         return _battlePoints;
      }
      
      public function get isFriend() : Boolean
      {
         return _isFriend;
      }
      
      public function get isAllianceEnemy() : Boolean
      {
         return _isAllianceEnemy;
      }
      
      public function get isRevanchist() : Boolean
      {
         return _isRevanchist;
      }
      
      public function get canBeRetaliated() : Boolean
      {
         return _canBeRetaliated;
      }
      
      public function get isEventNpc() : Boolean
      {
         return _isEventNpc;
      }
      
      public function get numberOfWins() : int
      {
         return _numberOfWins;
      }
      
      public function get profileAccordingToTutorial() : Profile
      {
         return _profileAccordingToTutorial;
      }
      
      public function set profileAccordingToTutorial(param1:Profile) : void
      {
         _profileAccordingToTutorial = param1;
      }
   }
}

