package wom.controller.command.user
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.facebook.FacebookFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.GetUserIdsOfFriendsResp;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   
   public class HandleGetUserIdsOfFriendsRespCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function HandleGetUserIdsOfFriendsRespCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:GetUserIdsOfFriendsResp = messageReceivedEvent.message as GetUserIdsOfFriendsResp;
         var _loc4_:Vector.<FriendInfo> = new Vector.<FriendInfo>();
         var _loc5_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc1_ in _loc2_.facebookFriendInfos)
         {
            for each(var _loc3_ in documentConfiguration.friends)
            {
               if(_loc3_.profile.platformId == _loc1_.fbId)
               {
                  _loc3_.profile.gameId = _loc1_.gameUid;
                  _loc3_.experiencePoints = _loc1_.xp;
                  _loc3_.coaInfo = CoatOfArmsDeserializeUtil.createCoatOfArmsInfo(_loc1_.coa);
                  documentConfiguration.womFriends[_loc1_.gameUid] = _loc3_;
                  _loc4_.push(_loc3_);
                  documentConfiguration.friends.splice(documentConfiguration.friends.indexOf(_loc3_),1);
                  _loc5_.push(new ProfileIdPair(_loc1_.fbId,null));
                  break;
               }
            }
         }
         documentConfiguration.friends.length = 0;
         documentConfiguration.friends = _loc4_;
         dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc5_));
         dispatch(new ModelUpdateEvent("friendsUpdated"));
      }
   }
}

