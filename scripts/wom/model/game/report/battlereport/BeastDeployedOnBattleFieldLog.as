package wom.model.game.report.battlereport
{
   public class BeastDeployedOnBattleFieldLog extends BattleReportLog
   {
      
      private var _beastId:int;
      
      public function BeastDeployedOnBattleFieldLog(param1:Number, param2:int)
      {
         super(6,param1);
         _beastId = param2;
      }
      
      public function get beastId() : int
      {
         return _beastId;
      }
   }
}

