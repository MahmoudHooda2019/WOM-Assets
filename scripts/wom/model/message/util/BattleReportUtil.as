package wom.model.message.util
{
   import flash.utils.Dictionary;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.game.report.battlereport.BattleReportLog;
   import wom.model.game.report.battlereport.BuildingDestroyedOrDamagedLog;
   import wom.model.game.report.battlereport.TroopsDeployedOnBattleFieldLog;
   import wom.model.game.resource.ResourceType;
   
   public class BattleReportUtil
   {
      
      public function BattleReportUtil()
      {
         super();
      }
      
      public static function deserializeBattleReport(param1:Number, param2:Number, param3:Object) : BattleReport
      {
         var _loc6_:BattleReportLog = null;
         var _loc4_:int = 0;
         var _loc17_:Boolean = false;
         var _loc21_:Vector.<ResourceAmountDTO> = new Vector.<ResourceAmountDTO>();
         var _loc25_:Dictionary = new Dictionary();
         var _loc22_:Vector.<PartInfoDTO> = new Vector.<PartInfoDTO>();
         var _loc10_:Vector.<BattleReportLog> = new Vector.<BattleReportLog>();
         var _loc11_:int = 0;
         var _loc15_:int = 0;
         if(param3["lr"])
         {
            _loc4_ = 0;
            while(_loc4_ < param3["lr"].length)
            {
               _loc25_[param3["lr"][_loc4_].id] = new ResourceAmountDTO(param3["lr"][_loc4_].id,param3["lr"][_loc4_].amount);
               _loc4_++;
            }
         }
         for each(var _loc16_ in ResourceType.resourceTypes)
         {
            if(_loc16_.id in _loc25_)
            {
               _loc21_.push(_loc25_[_loc16_.id]);
            }
            else
            {
               _loc21_.push(new ResourceAmountDTO(_loc16_.id,0));
            }
         }
         if("lp" in param3 && param3["lp"] != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param3["lp"].length)
            {
               _loc22_.push(new PartInfoDTO(param3["lp"][_loc4_].id,"",param3["lp"][_loc4_].amount));
               _loc4_++;
            }
         }
         var _loc14_:Dictionary = new Dictionary();
         var _loc19_:BuildingDestroyedOrDamagedLog = null;
         _loc4_ = 0;
         while(_loc4_ < param3["brl"].length)
         {
            _loc6_ = BattleReportLog.createBattleReportLog(param3["brl"][_loc4_]);
            if(_loc6_.logType == 6)
            {
               _loc11_ += 1;
            }
            if(_loc6_.logType == 4 && _loc10_.length > 0 && (_loc6_ as TroopsDeployedOnBattleFieldLog).troops.length == 1)
            {
               _loc17_ = false;
               for each(var _loc8_ in _loc10_)
               {
                  if(_loc8_.logType == 4 && (_loc8_ as TroopsDeployedOnBattleFieldLog).troops.length == 1 && (_loc8_ as TroopsDeployedOnBattleFieldLog).troops[0].id == (_loc6_ as TroopsDeployedOnBattleFieldLog).troops[0].id && int((_loc8_ as TroopsDeployedOnBattleFieldLog).occurrenceTimeInMillis / 2000) == int((_loc6_ as TroopsDeployedOnBattleFieldLog).occurrenceTimeInMillis / 2000))
                  {
                     (_loc8_ as TroopsDeployedOnBattleFieldLog).troops[0].amount += (_loc6_ as TroopsDeployedOnBattleFieldLog).troops[0].amount;
                     _loc8_.deployedMercsCount += _loc6_.deployedMercsCount;
                     _loc17_ = true;
                     break;
                  }
               }
               if(!_loc17_)
               {
                  _loc10_.push(_loc6_);
               }
            }
            else if(_loc6_.logType == 1)
            {
               _loc19_ = _loc6_ as BuildingDestroyedOrDamagedLog;
               if(!(_loc19_.groupIdentifier in _loc14_))
               {
                  _loc14_[_loc19_.groupIdentifier] = _loc19_;
                  _loc10_.push(_loc19_);
               }
               else
               {
                  _loc19_ = _loc14_[_loc19_.groupIdentifier];
                  _loc19_.increaseAmount();
               }
            }
            else
            {
               _loc10_.push(_loc6_);
            }
            _loc11_ += _loc6_.deployedMercsCount;
            _loc15_ += _loc6_.destroyedBuildingsCount;
            _loc4_++;
         }
         var _loc7_:int = int(param3["dp"] == null ? -1 : param3["dp"]);
         var _loc9_:int = int(param3["idp"] == null ? 0 : param3["idp"]);
         var _loc18_:Boolean = Boolean("ta" in param3 ? param3["ta"] : false);
         var _loc13_:int = int(param3["al"] == null ? -1 : param3["al"]);
         var _loc24_:int = int(_loc18_ ? 1 : (param3["dl"] == null ? -1 : param3["dl"]));
         var _loc12_:AllianceSummaryInfo = AllianceDeserializeUtil.deserializeAllianceSummary(param3["aa"]);
         var _loc20_:AllianceSummaryInfo = AllianceDeserializeUtil.deserializeAllianceSummary(param3["da"]);
         var _loc5_:Boolean = Boolean("tra" in param3 ? param3["tra"] : false);
         var _loc23_:int = int("tp" in param3 ? param3["tp"] : 0);
         return new BattleReport(param1,param2,_loc21_,_loc22_,_loc11_,_loc15_,_loc10_.sort(compareBattleReportLogs),_loc7_,_loc9_,param3["qa"],_loc13_,_loc24_,_loc12_,_loc20_,_loc18_,_loc5_,_loc23_);
      }
      
      private static function compareBattleReportLogs(param1:BattleReportLog, param2:BattleReportLog) : Number
      {
         if(param1.occurrenceTimeInMillis < param2.occurrenceTimeInMillis)
         {
            return -1;
         }
         if(param1.occurrenceTimeInMillis > param2.occurrenceTimeInMillis)
         {
            return 1;
         }
         return 0;
      }
   }
}

