package wom.model.game.report
{
   import wom.model.game.Profile;
   import wom.model.game.TutorialDefender;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class AttackLog
   {
      
      private var _id:Number;
      
      private var _attacker:Profile;
      
      private var _defender:Profile;
      
      private var _attackDurationInMillis:Number;
      
      private var _attackStartInMillis:Number;
      
      private var _isRead:Boolean;
      
      private var _isQuickAttack:Boolean;
      
      private var _star:int;
      
      private var _battlePointDifference:int;
      
      private var _eventPoints:int;
      
      private var _attackerAlliance:AllianceSummaryInfo;
      
      private var _defenderAlliance:AllianceSummaryInfo;
      
      private var _attackerLevel:int;
      
      private var _defenderLevel:int;
      
      private var _tutorialAttack:Boolean;
      
      private var _npcDefeated:Boolean;
      
      public function AttackLog(param1:Number, param2:Profile, param3:AllianceSummaryInfo, param4:Profile, param5:AllianceSummaryInfo, param6:Number, param7:Number, param8:Boolean, param9:Boolean, param10:int, param11:int, param12:int, param13:int, param14:int, param15:Boolean)
      {
         super();
         _id = param1;
         _attacker = param2;
         _attackerAlliance = param3;
         _defender = param4;
         _defenderAlliance = param5;
         _attackDurationInMillis = param6;
         _attackStartInMillis = param7;
         _isRead = param8;
         _isQuickAttack = param9;
         _star = param10;
         _battlePointDifference = param11;
         _eventPoints = param12;
         _attackerLevel = param13;
         _defenderLevel = param14;
         _tutorialAttack = param15;
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function get attacker() : Profile
      {
         return _attacker;
      }
      
      public function get defender() : Profile
      {
         return _tutorialAttack ? TutorialDefender.PROFILE : _defender;
      }
      
      public function get attackDurationInMillis() : Number
      {
         return _attackDurationInMillis;
      }
      
      public function get attackStartInMillis() : Number
      {
         return _attackStartInMillis;
      }
      
      public function get isRead() : Boolean
      {
         return _isRead;
      }
      
      public function set isRead(param1:Boolean) : void
      {
         _isRead = param1;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function get star() : int
      {
         return _star;
      }
      
      public function get battlePointDifference() : int
      {
         return _battlePointDifference;
      }
      
      public function get eventPoints() : int
      {
         return _eventPoints;
      }
      
      public function get attackerAlliance() : AllianceSummaryInfo
      {
         return _attackerAlliance;
      }
      
      public function get defenderAlliance() : AllianceSummaryInfo
      {
         return _defenderAlliance;
      }
      
      public function get attackerLevel() : int
      {
         return _attackerLevel;
      }
      
      public function get defenderLevel() : int
      {
         return _defenderLevel;
      }
      
      public function get tutorialAttack() : Boolean
      {
         return _tutorialAttack;
      }
      
      public function get npcDefeated() : Boolean
      {
         return _npcDefeated;
      }
      
      public function set npcDefeated(param1:Boolean) : void
      {
         _npcDefeated = param1;
      }
   }
}

