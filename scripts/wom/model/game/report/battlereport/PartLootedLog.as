package wom.model.game.report.battlereport
{
   import wom.model.dto.PartInfoDTO;
   
   public class PartLootedLog extends BattleReportLog
   {
      
      private var _lootedPart:PartInfoDTO;
      
      public function PartLootedLog(param1:int, param2:Number, param3:PartInfoDTO)
      {
         super(param1,param2);
         _lootedPart = param3;
      }
      
      public function get lootedPart() : PartInfoDTO
      {
         return _lootedPart;
      }
   }
}

