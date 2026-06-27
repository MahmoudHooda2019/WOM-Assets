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
   import wom.model.message.response.alliance.GetAllianceCandidatesResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleGetAllianceCandidatesResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleGetAllianceCandidatesResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:* = undefined;
         var _loc2_:GetAllianceCandidatesResponse = event.message as GetAllianceCandidatesResponse;
         if(_loc2_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc2_.resultCode,GenericActionPopUp);
            return;
         }
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
            allianceInfo.myAllianceCandidates = new AllianceMembersRankingInfo(allianceInfo.myAllianceSummary.id,allianceInfo.myAllianceSummary.name,_loc2_.candidates);
            dispatch(new ModelUpdateEvent("myAllianceCandidatesUpdated"));
         }
      }
   }
}

