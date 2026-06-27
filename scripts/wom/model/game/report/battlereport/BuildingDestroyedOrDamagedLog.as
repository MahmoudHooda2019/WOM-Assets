package wom.model.game.report.battlereport
{
   public class BuildingDestroyedOrDamagedLog extends BattleReportLog
   {
      
      private static const LOG_GROUP_TIME_INTERVAL_MILLIS:int = 2000;
      
      private var _buildingTypeId:int;
      
      private var _damagePercent:int;
      
      private var _level:int;
      
      private var _amount:int;
      
      public function BuildingDestroyedOrDamagedLog(param1:Number, param2:int, param3:int, param4:int)
      {
         super(1,param1);
         _buildingTypeId = param2;
         _damagePercent = param3;
         _level = param4;
         _amount = 1;
      }
      
      public function get groupIdentifier() : String
      {
         return _buildingTypeId + "_" + _damagePercent + "_" + int(occurrenceTimeInMillis / 2000);
      }
      
      public function get buildingTypeId() : int
      {
         return _buildingTypeId;
      }
      
      public function get damagePercent() : int
      {
         return _damagePercent;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function increaseAmount() : void
      {
         _amount = _amount + 1;
      }
   }
}

