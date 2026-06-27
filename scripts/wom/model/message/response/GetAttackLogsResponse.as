package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.report.AttackLog;
   import wom.model.game.report.MobileAttackLog;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class GetAttackLogsResponse extends AbstractIncomingMessage
   {
      
      private var _attackLogs:Vector.<AttackLog>;
      
      public function GetAttackLogsResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc6_:Profile = null;
         var _loc8_:Profile = null;
         var _loc10_:AllianceSummaryInfo = null;
         var _loc3_:AllianceSummaryInfo = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc2_:Boolean = false;
         _attackLogs = new Vector.<AttackLog>();
         var _loc7_:Dictionary = new Dictionary();
         for each(var _loc11_ in param1.logs)
         {
            _loc5_ = 0;
            _loc4_ = 0;
            if("battlePoints" in _loc11_ && _loc11_.battlePoints != null)
            {
               _loc5_ = int(_loc11_.battlePoints.star);
               _loc4_ = int(_loc11_.battlePoints.battlePointDifference);
            }
            _loc9_ = int(_loc11_.eventPoint != null ? _loc11_.eventPoint : -1);
            _loc6_ = new Profile(_loc11_.attacker[0],_loc11_.attacker[1],_loc11_.attacker[2]);
            if("defenderNpcName" in _loc11_ && _loc11_.defenderNpcName != null)
            {
               _loc8_ = new Profile(null,null,null,_loc11_.defenderNpcName,_loc11_.defenderNpcClanId);
            }
            else
            {
               _loc8_ = new Profile(_loc11_.defender[0],_loc11_.defender[1],_loc11_.defender[2]);
            }
            _loc12_ = int(_loc11_.attackerLevel == null ? -1 : _loc11_.attackerLevel);
            _loc13_ = int(_loc11_.defenderLevel == null ? -1 : _loc11_.defenderLevel);
            _loc2_ = Boolean("tutorialAttack" in _loc11_ ? _loc11_["tutorialAttack"] : false);
            _loc10_ = AllianceDeserializeUtil.deserializeAllianceSummary(_loc11_.attackerAlliance);
            _loc3_ = AllianceDeserializeUtil.deserializeAllianceSummary(_loc11_.defenderAlliance);
            _attackLogs.push(new MobileAttackLog(_loc11_.id,_loc6_,_loc10_,_loc8_,_loc3_,_loc11_.attackDurationInMillis,_loc11_.attackStartInMillis,_loc11_.isRead,_loc11_.quickAttack,_loc5_,_loc4_,_loc9_,_loc12_,_loc13_,_loc2_));
            if(_loc8_.npcClan == "NPC-6" && _loc5_ > 0)
            {
               _loc7_[_loc8_.npcId] = true;
            }
         }
         markDefeatedEventNPCs(_loc7_);
         _attackLogs = _attackLogs.sort(compareAttackLogs);
      }
      
      private function markDefeatedEventNPCs(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AttackLog = null;
         _loc3_ = 0;
         while(_loc3_ < _attackLogs.length)
         {
            _loc2_ = _attackLogs[_loc3_];
            if(_loc2_.defender.npcClan == "NPC-6")
            {
               _loc2_.npcDefeated = param1[_loc2_.defender.npcId];
            }
            _loc3_++;
         }
      }
      
      public function get attackLogs() : Vector.<AttackLog>
      {
         return _attackLogs;
      }
      
      private function compareAttackLogs(param1:AttackLog, param2:AttackLog) : Number
      {
         if(param1.attackDurationInMillis < param2.attackDurationInMillis)
         {
            return -1;
         }
         if(param1.attackDurationInMillis > param2.attackDurationInMillis)
         {
            return 1;
         }
         return 0;
      }
   }
}

