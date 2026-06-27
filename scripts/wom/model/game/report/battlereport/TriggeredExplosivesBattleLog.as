package wom.model.game.report.battlereport
{
   public class TriggeredExplosivesBattleLog extends BattleReportLog
   {
      
      private var _typeId:int;
      
      public function TriggeredExplosivesBattleLog(param1:Number, param2:int)
      {
         super(7,param1);
         _typeId = param2;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
   }
}

