package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceMembersRankingInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.alliance.SearchAllianceCandidateResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleSearchAllianceCandidateResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleSearchAllianceCandidateResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:* = undefined;
         var _loc2_:SearchAllianceCandidateResponse = event.message as SearchAllianceCandidateResponse;
         if(_loc2_.resultCode == 0)
         {
            if(allianceInfo.myAllianceSummary != null)
            {
               _loc3_ = new Vector.<ProfileIdPair>();
               for each(var _loc1_ in _loc2_.candidates)
               {
                  _loc3_.push(new ProfileIdPair(_loc1_.profile.platformId,_loc1_.profile.avatar));
               }
               if(_loc3_.length > 0)
               {
                  dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc3_));
               }
               allianceInfo.searchedAllianceCandidates = new AllianceMembersRankingInfo(allianceInfo.myAllianceSummary.id,allianceInfo.myAllianceSummary.name,_loc2_.candidates);
               dispatch(new ModelUpdateEvent("searchedAllianceCandidatesUpdated"));
            }
         }
         else
         {
            errorCodeRepository.dispatchError("Alliance",_loc2_.resultCode,GenericActionPopUp);
         }
      }
   }
}

