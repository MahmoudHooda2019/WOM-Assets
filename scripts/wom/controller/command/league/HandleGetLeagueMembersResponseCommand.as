package wom.controller.command.league
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.message.response.league.GetLeagueMembersResponse;
   import wom.service.facebook.FacebookAPIManager;
   
   public class HandleGetLeagueMembersResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function HandleGetLeagueMembersResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:GetLeagueMembersResponse = null;
         var _loc3_:* = undefined;
         if(leagueManager.myLeague != null)
         {
            _loc2_ = event.message as GetLeagueMembersResponse;
            _loc3_ = new Vector.<ProfileIdPair>();
            for each(var _loc1_ in _loc2_.members)
            {
               _loc3_.push(new ProfileIdPair(_loc1_.profile.platformId,_loc1_.profile.avatar));
            }
            if(_loc3_.length > 0)
            {
               dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc3_));
            }
            updateMemberNames(_loc2_.members);
            leagueManager.myLeague.members = _loc2_.members;
            dispatch(new ModelUpdateEvent("leagueMembersRankingInfoUpdated"));
         }
      }
      
      private function updateMemberNames(param1:Vector.<LeagueMemberInfo>) : void
      {
         for each(var _loc2_ in param1)
         {
            _loc2_.name = _loc2_.profile.mobileName ? _loc2_.profile.mobileName : facebookAPIManager.getUserNameByProfile(_loc2_.profile);
         }
      }
   }
}

