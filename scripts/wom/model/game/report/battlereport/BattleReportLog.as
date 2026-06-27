package wom.model.game.report.battlereport
{
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.combat.CatapultInfo;
   
   public class BattleReportLog
   {
      
      public static const INVALID_BATTLE_REPORT_LOG:int = 0;
      
      public static const BUILDING_DESTROYED_OR_DAMAGED:int = 1;
      
      public static const TROOP_RELEASED_FROM_WATCH_POST:int = 2;
      
      public static const BEAST_FLEES:int = 3;
      
      public static const TROOPS_DEPLOYED_ON_BATTLEFIELD:int = 4;
      
      public static const CATAPULT_USED:int = 5;
      
      public static const BEAST_DEPLOYED_ON_BATTLEFIELD:int = 6;
      
      public static const EXPLOSIVES_TRIGGERED:int = 7;
      
      public static const PART_LOOTED:int = 666;
      
      private var _logType:int;
      
      private var _occurrenceTimeInMillis:Number;
      
      private var _deployedMercsCount:int;
      
      private var _destroyedBuildingsCount:int;
      
      public function BattleReportLog(param1:int, param2:Number)
      {
         super();
         _logType = param1;
         _occurrenceTimeInMillis = param2;
         _deployedMercsCount = 0;
         _destroyedBuildingsCount = 0;
      }
      
      public static function createBattleReportLog(param1:Object) : BattleReportLog
      {
         var _loc2_:int = 0;
         var _loc5_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:BattleReportLog = null;
         switch(param1.lt)
         {
            case 1:
               _loc3_ = new BuildingDestroyedOrDamagedLog(param1.ot,param1.bd.b,param1.bd.d,param1.bd.l);
               if(param1.bd.d <= 0)
               {
                  _loc3_.destroyedBuildingsCount++;
               }
               break;
            case 2:
               _loc5_ = new Vector.<UnitTypeAmountDTO>();
               _loc2_ = 0;
               while(_loc2_ < param1.t.length)
               {
                  _loc5_.push(new UnitTypeAmountDTO(param1.t[_loc2_].id,param1.t[_loc2_].amount));
                  _loc2_++;
               }
               _loc3_ = new TroopsReleaseFromWatchpostLog(param1.ot,_loc5_);
               break;
            case 3:
               _loc3_ = new BeastFledLog(param1.ot,param1.ia,param1.bi);
               break;
            case 4:
               _loc5_ = new Vector.<UnitTypeAmountDTO>();
               _loc4_ = 0;
               _loc2_ = 0;
               while(_loc2_ < param1.t.length)
               {
                  _loc5_.push(new UnitTypeAmountDTO(param1.t[_loc2_].id,param1.t[_loc2_].amount));
                  _loc4_ += param1.t[_loc2_].amount;
                  _loc2_++;
               }
               _loc3_ = new TroopsDeployedOnBattleFieldLog(param1.ot,_loc5_);
               _loc3_.deployedMercsCount = _loc4_;
               break;
            case 5:
               _loc3_ = new CatapultUsedLog(param1.ot,new CatapultInfo(param1["c"].id,param1["c"].size));
               break;
            case 6:
               _loc3_ = new BeastDeployedOnBattleFieldLog(param1.ot,param1.bi);
               break;
            case 7:
               _loc3_ = new TriggeredExplosivesBattleLog(param1.ot,param1.e);
               break;
            default:
               _loc3_ = new EmptyBattleLog();
         }
         return _loc3_;
      }
      
      public function get logType() : int
      {
         return _logType;
      }
      
      public function get occurrenceTimeInMillis() : Number
      {
         return _occurrenceTimeInMillis;
      }
      
      public function get deployedMercsCount() : int
      {
         return _deployedMercsCount;
      }
      
      public function get destroyedBuildingsCount() : int
      {
         return _destroyedBuildingsCount;
      }
      
      public function set destroyedBuildingsCount(param1:int) : void
      {
         _destroyedBuildingsCount = param1;
      }
      
      public function set deployedMercsCount(param1:int) : void
      {
         _deployedMercsCount = param1;
      }
   }
}

