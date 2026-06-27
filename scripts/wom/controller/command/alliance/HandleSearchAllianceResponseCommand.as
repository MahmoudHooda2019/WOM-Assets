package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.SearchAllianceResponse;
   
   public class HandleSearchAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleSearchAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AllianceDetailInfo = null;
         var _loc2_:SearchAllianceResponse = event.message as SearchAllianceResponse;
         allianceInfo.searchedAllianceRankingInfo = _loc2_.rankingInfo;
         _loc3_ = 0;
         while(_loc3_ < allianceInfo.searchedAllianceRankingInfo.alliances.length)
         {
            _loc1_ = allianceInfo.searchedAllianceRankingInfo.alliances[_loc3_];
            if(_loc1_.id in allianceInfo.requestedAllianceIds)
            {
               _loc1_.requestSent = true;
            }
            _loc3_++;
         }
         dispatch(new ModelUpdateEvent("allianceSearchResultUpdated"));
      }
   }
}

