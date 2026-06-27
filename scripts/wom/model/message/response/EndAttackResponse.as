package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.attack.CatapultTimeUtil;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.message.util.AllianceDeserializeUtil;
   import wom.model.message.util.BattleReportUtil;
   
   public class EndAttackResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _defender:Profile;
      
      private var _attackerAttackLogId:Number;
      
      private var _attackStartTimeInMillis:Number;
      
      private var _attackDurationInMillis:Number;
      
      private var _battleReport:BattleReport = null;
      
      private var _lastCatapultFiredTimes:Dictionary;
      
      private var _star:int;
      
      private var _battlePointDifference:int;
      
      private var _eventPoints:int;
      
      private var _defenderAlliance:AllianceSummaryInfo;
      
      public function EndAttackResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if("defenderNpcName" in param1 && param1.defenderNpcName != null)
         {
            _defender = new Profile(null,null,null,param1.defenderNpcName,param1.defenderNpcClanId);
         }
         else
         {
            _defender = new Profile(param1.defender[0],param1.defender[1],param1.defender[2]);
         }
         _attackerAttackLogId = param1.attackerAttackLogId;
         _attackStartTimeInMillis = param1.attackStartTimeInMillis;
         _attackDurationInMillis = param1.attackDurationInMillis;
         _star = 0;
         _battlePointDifference = 0;
         if("battlePoints" in param1 && param1.battlePoints != null)
         {
            _star = param1.battlePoints.star;
            _battlePointDifference = param1.battlePoints.battlePointDifference;
         }
         _eventPoints = param1.eventPoint != null ? param1.eventPoint : -1;
         _lastCatapultFiredTimes = CatapultTimeUtil.deserializeCatapultTimes(param1.lastCatapultFiredTimes);
         var _loc2_:Number = NaN;
         if("guid" in param1 && param1.guid)
         {
            _loc2_ = Number(param1.guid);
         }
         if("battleReport" in param1 && param1.battleReport != null && _attackerAttackLogId > -1)
         {
            _battleReport = BattleReportUtil.deserializeBattleReport(_attackerAttackLogId,_loc2_,param1.battleReport);
         }
         _defenderAlliance = AllianceDeserializeUtil.deserializeAllianceSummary(param1.defenderAlliance);
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get defender() : Profile
      {
         return _defender;
      }
      
      public function get attackerAttackLogId() : Number
      {
         return _attackerAttackLogId;
      }
      
      public function get attackStartTimeInMillis() : Number
      {
         return _attackStartTimeInMillis;
      }
      
      public function get battleReport() : BattleReport
      {
         return _battleReport;
      }
      
      public function get attackDurationInMillis() : Number
      {
         return _attackDurationInMillis;
      }
      
      public function get lastCatapultFiredTimes() : Dictionary
      {
         return _lastCatapultFiredTimes;
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
      
      public function get defenderAlliance() : AllianceSummaryInfo
      {
         return _defenderAlliance;
      }
   }
}

