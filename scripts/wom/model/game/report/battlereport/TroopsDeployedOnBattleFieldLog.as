package wom.model.game.report.battlereport
{
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class TroopsDeployedOnBattleFieldLog extends BattleReportLog
   {
      
      private var _troops:Vector.<UnitTypeAmountDTO>;
      
      public function TroopsDeployedOnBattleFieldLog(param1:Number, param2:Vector.<UnitTypeAmountDTO>)
      {
         super(4,param1);
         _troops = param2;
      }
      
      public function get troops() : Vector.<UnitTypeAmountDTO>
      {
         return _troops;
      }
   }
}

