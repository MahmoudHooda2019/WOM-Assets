package wom.model.game.friend
{
   import wom.model.game.Profile;
   
   public class BlockedFriendInfo
   {
      
      private var _profile:Profile;
      
      private var _expirationTimer:int;
      
      public function BlockedFriendInfo(param1:Profile, param2:int)
      {
         super();
         _profile = param1;
         _expirationTimer = param2;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get expirationTimer() : int
      {
         return _expirationTimer;
      }
   }
}

