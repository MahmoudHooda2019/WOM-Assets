package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.alliance.GetAllianceMembersResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleGetAllianceMembersResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleGetAllianceMembersResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:GetAllianceMembersResponse = event.message as GetAllianceMembersResponse;
         if(_loc2_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc2_.resultCode,GenericActionPopUp);
            return;
         }
         var _loc3_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc1_ in _loc2_.membersRankingInfo.members)
         {
            _loc3_.push(new ProfileIdPair(_loc1_.profile.platformId,_loc1_.profile.avatar));
         }
         if(_loc3_.length > 0)
         {
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc3_));
         }
         allianceInfo.membersRankingInfo = _loc2_.membersRankingInfo;
         dispatch(new ModelUpdateEvent("allianceMembersRankingInfoUpdated"));
      }
   }
}

