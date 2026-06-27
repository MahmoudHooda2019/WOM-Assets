package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.alliance.GetAllianceMemberContributionsResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleGetAllianceMemberContributionsResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function HandleGetAllianceMemberContributionsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:Boolean = false;
         for each(var _loc3_ in cityInfo.buildings)
         {
            if(_loc3_.buildingTypeId == 42)
            {
               _loc5_ = _loc3_.level >= 3;
               break;
            }
         }
         var _loc2_:GetAllianceMemberContributionsResponse = event.message as GetAllianceMemberContributionsResponse;
         if(_loc2_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc2_.resultCode,GenericActionPopUp);
            return;
         }
         var _loc4_:Boolean = allianceInfo.myAllianceSummary && allianceInfo.myAllianceSummary.role == AllianceRoleType.LEADER;
         var _loc6_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc1_ in _loc2_.membersRankingInfo.members)
         {
            _loc6_.push(new ProfileIdPair(_loc1_.profile.platformId,_loc1_.profile.avatar));
            if(_loc1_.profile.gameId != userInfo.profile.gameId)
            {
               if(_loc4_)
               {
                  _loc1_.type = _loc5_ ? 3 : 9;
               }
               else if(_loc5_)
               {
                  _loc1_.type = 8;
               }
            }
         }
         if(_loc6_.length > 0)
         {
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc6_));
         }
         allianceInfo.myAllianceMembersRankingInfo = _loc2_.membersRankingInfo;
         dispatch(new ModelUpdateEvent("myAllianceMembersRankingInfoUpdated"));
      }
   }
}

