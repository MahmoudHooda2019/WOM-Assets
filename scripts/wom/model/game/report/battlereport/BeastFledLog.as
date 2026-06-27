package wom.model.game.report.battlereport
{
   public class BeastFledLog extends BattleReportLog
   {
      
      private var _beastId:int;
      
      private var _isAttacker:Boolean;
      
      public function BeastFledLog(param1:Number, param2:Boolean, param3:int)
      {
         super(3,param1);
         _isAttacker = param2;
         _beastId = param3;
      }
      
      public function get beastId() : int
      {
         return _beastId;
      }
      
      public function get isAttacker() : Boolean
      {
         return _isAttacker;
      }
   }
}

