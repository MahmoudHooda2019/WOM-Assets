package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.message.util.BattleReportUtil;
   
   public class GetBattleReportResponse extends AbstractIncomingMessage
   {
      
      private var _battleReport:BattleReport;
      
      public function GetBattleReportResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         if("logId" in param1 && "battleReport" in param1 && param1.battleReport != null)
         {
            _loc2_ = NaN;
            if("guid" in param1 && param1.guid)
            {
               _loc2_ = Number(param1.guid);
            }
            _battleReport = BattleReportUtil.deserializeBattleReport(param1.logId,_loc2_,param1.battleReport);
         }
      }
      
      public function get battleReport() : BattleReport
      {
         return _battleReport;
      }
   }
}

