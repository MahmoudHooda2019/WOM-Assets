package wom.model.dto.combat
{
   import flash.utils.Dictionary;
   import wom.model.game.resource.ResourceType;
   
   public class PostBattleInfo
   {
      
      private var _attackerBeastFledLog:ReceivedBeastFledBattleFieldLog;
      
      private var _defenderBeastFledLog:ReceivedBeastFledBattleFieldLog;
      
      private var _buildingDamagedLogs:Dictionary;
      
      private var _troopsReleasedFromWatchPostLogs:Dictionary;
      
      private var _attackerInfo:PostBattleAttackerInfo;
      
      private var _defenderInfo:PostBattleDefenderInfo;
      
      private var _lootedHarvestedResources:Array;
      
      private var _lootedUnharvestedResources:Dictionary;
      
      private var _explosivesTriggeredLogs:Vector.<TriggeredExplosiveInfo>;
      
      private var _endFrame:int;
      
      private var _beastReatreatFrameNumber:int;
      
      private var _battleRecords:String;
      
      public function PostBattleInfo(param1:ReceivedBeastFledBattleFieldLog, param2:ReceivedBeastFledBattleFieldLog, param3:Dictionary, param4:Dictionary, param5:PostBattleAttackerInfo, param6:PostBattleDefenderInfo, param7:Array, param8:Dictionary, param9:Vector.<TriggeredExplosiveInfo>, param10:int, param11:int, param12:String)
      {
         super();
         _attackerBeastFledLog = param1;
         _defenderBeastFledLog = param2;
         _buildingDamagedLogs = param3;
         _troopsReleasedFromWatchPostLogs = param4;
         _attackerInfo = param5;
         _defenderInfo = param6;
         _lootedHarvestedResources = param7;
         _lootedUnharvestedResources = param8;
         _explosivesTriggeredLogs = param9;
         _endFrame = param10;
         _beastReatreatFrameNumber = param11;
         _battleRecords = param12;
      }
      
      public function serialize() : Object
      {
         var _loc1_:int = 0;
         var _loc11_:Array = null;
         var _loc4_:ReceivedTroopsReleasedFromWatchPostLog = null;
         var _loc8_:Array = [];
         var _loc7_:Array = [];
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         var _loc6_:Array = [];
         for each(var _loc12_ in ResourceType.resourceTypes)
         {
            _loc1_ = _loc12_.id;
            if(_lootedHarvestedResources[_loc1_])
            {
               _loc8_.push({
                  "id":_loc1_,
                  "amount":_lootedHarvestedResources[_loc1_]
               });
            }
         }
         for(var _loc5_ in _lootedUnharvestedResources)
         {
            _loc7_.push({
               "instanceId":_loc5_,
               "amount":_lootedUnharvestedResources[_loc5_]
            });
         }
         for(_loc5_ in _buildingDamagedLogs)
         {
            _loc3_.push({
               "type":"buildingDamaged",
               "instanceId":_loc5_,
               "occurrenceTimeInMillis":_buildingDamagedLogs[_loc5_]
            });
         }
         for(_loc5_ in _troopsReleasedFromWatchPostLogs)
         {
            _loc4_ = _troopsReleasedFromWatchPostLogs[_loc5_];
            _loc11_ = [];
            for(var _loc10_ in _loc4_.troopCounts)
            {
               _loc11_.push({
                  "id":_loc10_,
                  "amount":_loc4_.troopCounts[_loc10_]
               });
            }
            _loc2_.push({
               "type":"troopsReleasedFromWatchPost",
               "occurrenceTimeInMillis":_loc4_.occurrenceTimeInMillis,
               "troops":_loc11_
            });
         }
         for each(var _loc9_ in _explosivesTriggeredLogs)
         {
            _loc6_.push({
               "type":"explosivesTriggered",
               "explosiveTypeId":_loc9_.typeId,
               "occurrenceTimeInMillis":_loc9_.occurenceTimeInMillis
            });
         }
         return {
            "attackerBeastFledLog":(_attackerBeastFledLog ? {
               "occurrenceTimeInMillis":_attackerBeastFledLog.occurrenceTimeInMillis,
               "beastId":_attackerBeastFledLog.beastTypeId,
               "type":"beastFled"
            } : null),
            "defenderBeastFledLog":(_defenderBeastFledLog ? {
               "occurrenceTimeInMillis":_defenderBeastFledLog.occurrenceTimeInMillis,
               "beastId":_defenderBeastFledLog.beastTypeId,
               "type":"beastFled"
            } : null),
            "buildingDamagedLogs":_loc3_,
            "troopsReleasedFromWatchPostLogs":_loc2_,
            "attackerInfo":_attackerInfo.serialize(),
            "defenderInfo":_defenderInfo.serialize(),
            "lootedHarvestedResources":_loc8_,
            "lootedUnharvestedResources":_loc7_,
            "explosivesTriggeredLogs":_loc6_,
            "brf":_beastReatreatFrameNumber,
            "ef":_endFrame,
            "br":_battleRecords
         };
      }
   }
}

