package wom.view.util
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.i18n.PText;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   import wom.model.game.friend.FriendInfo;
   
   public class FriendUtil
   {
      
      public function FriendUtil()
      {
         super();
      }
      
      public static function friendsCompare(param1:FriendInfo, param2:FriendInfo) : int
      {
         var _temp_1:* = param1.name;
         var _loc3_:String = param2.name;
         var _loc4_:String = _temp_1;
         return peak.i18n.PText.INSTANCE.activeLanguage.collator.compare(_loc4_,_loc3_);
      }
      
      public static function getWomFriendsVector(param1:Vector.<FriendInfo>, param2:Dictionary) : Vector.<FriendInfo>
      {
         var _loc3_:Vector.<FriendInfo> = new Vector.<FriendInfo>();
         for each(var _loc4_ in param1)
         {
            if(_loc4_.profile.gameId in param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_.sort(friendsCompare);
      }
      
      private static function getBlockedFriends(param1:int, param2:UserInfo) : Vector.<BlockedFriendInfo>
      {
         var _loc3_:Vector.<BlockedFriendInfo> = param2.blockedFriendsMap[param1];
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<BlockedFriendInfo>();
         }
         return _loc3_;
      }
      
      public static function getBlockedFriendsMap(param1:int, param2:WomDocumentConfiguration, param3:UserInfo) : Dictionary
      {
         var _loc6_:int = 0;
         var _loc4_:Dictionary = new Dictionary();
         if(param1 == 4)
         {
            if(!param2.hasParameter("ignoreInvites"))
            {
               for each(var _loc7_ in param2.friends)
               {
                  _loc4_[_loc7_.profile.toString()] = true;
               }
            }
         }
         else
         {
            _loc6_ = getTimer();
            for each(var _loc5_ in getBlockedFriends(param1,param3))
            {
               if(_loc6_ <= _loc5_.expirationTimer)
               {
                  _loc4_[_loc5_.profile.toString()] = true;
               }
            }
         }
         return _loc4_;
      }
      
      public static function getProfile(param1:Object) : Profile
      {
         return new Profile("gameid" in param1 ? param1.gameid : null,param1.fbid,null);
      }
   }
}

