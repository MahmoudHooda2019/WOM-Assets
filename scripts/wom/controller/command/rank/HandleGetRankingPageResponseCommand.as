package wom.controller.command.rank
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.rank.MobileRankingRow;
   import wom.model.game.rank.RankingInfo;
   import wom.model.message.response.GetRankingPageResponse;
   import wom.service.facebook.FacebookAPIManager;
   
   public class HandleGetRankingPageResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function HandleGetRankingPageResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetRankingPageResponse = event.message as GetRankingPageResponse;
         if(_loc1_.success)
         {
            setVisibleNames(_loc1_.rankingInfo);
            userInfo.rankingInfo = _loc1_.rankingInfo;
            dispatch(new ModelUpdateEvent("rankingInfoUpdated"));
         }
      }
      
      private function setVisibleNames(param1:RankingInfo) : void
      {
         var _loc3_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc2_ in param1.rankings)
         {
            if(_loc2_.profile.mobileName)
            {
               _loc2_.visibleName = _loc2_.profile.mobileName;
            }
            else if(_loc2_.profile.platformId)
            {
               _loc2_.visibleName = facebookAPIManager.getUserNameByProfile(_loc2_.profile);
            }
            if(_loc2_.profile.platformId && !isNaN(Number(_loc2_.profile.platformId)))
            {
               _loc3_.push(new ProfileIdPair(_loc2_.profile.platformId,_loc2_.profile.avatar));
            }
         }
         if(_loc3_.length > 0)
         {
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc3_));
         }
      }
   }
}

