package wom.model.game.report.battlereport
{
   import wom.model.dto.combat.CatapultInfo;
   
   public class CatapultUsedLog extends BattleReportLog
   {
      
      private var _catapultInfo:CatapultInfo;
      
      public function CatapultUsedLog(param1:Number, param2:CatapultInfo)
      {
         super(5,param1);
         _catapultInfo = param2;
      }
      
      public function get catapultInfo() : CatapultInfo
      {
         return _catapultInfo;
      }
   }
}

