package wom.model.game.report.battlereport
{
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class BattleReport
   {
      
      private var _attackLogId:Number;
      
      private var _opponentGuid:Number;
      
      private var _lootedResources:Vector.<ResourceAmountDTO>;
      
      private var _lootedParts:Vector.<PartInfoDTO>;
      
      private var _deployedMercsCount:int;
      
      private var _destroyedBuildingsCount:int;
      
      private var _battleReportLogs:Vector.<BattleReportLog>;
      
      private var _totalDamagePercentage:int;
      
      private var _lastBattleDamagePercentage:int;
      
      private var _isQuickAttack:Boolean;
      
      private var _attackerLevel:int;
      
      private var _defenderLevel:int;
      
      private var _attackerAlliance:AllianceSummaryInfo;
      
      private var _defenderAlliance:AllianceSummaryInfo;
      
      private var _tutorialAttack:Boolean;
      
      private var _isTournamentAttack:Boolean;
      
      private var _tournamentPoints:int;
      
      public function BattleReport(param1:Number, param2:Number, param3:Vector.<ResourceAmountDTO>, param4:Vector.<PartInfoDTO>, param5:int, param6:int, param7:Vector.<BattleReportLog>, param8:int, param9:int, param10:Boolean, param11:int, param12:int, param13:AllianceSummaryInfo, param14:AllianceSummaryInfo, param15:Boolean, param16:Boolean, param17:int)
      {
         super();
         _attackLogId = param1;
         _opponentGuid = param2;
         _lootedResources = param3;
         _lootedParts = param4;
         _deployedMercsCount = param5;
         _destroyedBuildingsCount = param6;
         _battleReportLogs = param7;
         _totalDamagePercentage = param8;
         _lastBattleDamagePercentage = param9;
         _isQuickAttack = param10;
         _attackerLevel = param11;
         _defenderLevel = param12;
         _attackerAlliance = param13;
         _defenderAlliance = param14;
         _tutorialAttack = param15;
         _isTournamentAttack = param16;
         _tournamentPoints = param17;
      }
      
      public function get attackLogId() : Number
      {
         return _attackLogId;
      }
      
      public function get opponentGuid() : Number
      {
         return _opponentGuid;
      }
      
      public function get lootedResources() : Vector.<ResourceAmountDTO>
      {
         return _lootedResources;
      }
      
      public function get lootedParts() : Vector.<PartInfoDTO>
      {
         return _lootedParts;
      }
      
      public function get deployedMercsCount() : int
      {
         return _deployedMercsCount;
      }
      
      public function get destroyedBuildingsCount() : int
      {
         return _destroyedBuildingsCount;
      }
      
      public function get battleReportLogs() : Vector.<BattleReportLog>
      {
         return _battleReportLogs;
      }
      
      public function get totalDamagePercentage() : int
      {
         return _totalDamagePercentage;
      }
      
      public function get lastBattleDamagePercentage() : int
      {
         return _lastBattleDamagePercentage;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function get attackerLevel() : int
      {
         return _attackerLevel;
      }
      
      public function get defenderLevel() : int
      {
         return _defenderLevel;
      }
      
      public function get attackerAlliance() : AllianceSummaryInfo
      {
         return _attackerAlliance;
      }
      
      public function get defenderAlliance() : AllianceSummaryInfo
      {
         return _defenderAlliance;
      }
      
      public function get tutorialAttack() : Boolean
      {
         return _tutorialAttack;
      }
      
      public function get isTournamentAttack() : Boolean
      {
         return _isTournamentAttack;
      }
      
      public function get tournamentPoints() : int
      {
         return _tournamentPoints;
      }
   }
}

