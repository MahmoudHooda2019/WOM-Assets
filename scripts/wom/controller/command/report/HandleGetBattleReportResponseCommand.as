package wom.controller.command.report
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.response.GetBattleReportResponse;
   
   public class HandleGetBattleReportResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleGetBattleReportResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetBattleReportResponse = event.message as GetBattleReportResponse;
         if(!(_loc1_.battleReport.attackLogId in userInfo.battleReports))
         {
            userInfo.battleReports[_loc1_.battleReport.attackLogId] = _loc1_.battleReport;
         }
         dispatch(new ModelUpdateEvent("battleReportUpdated"));
      }
   }
}

