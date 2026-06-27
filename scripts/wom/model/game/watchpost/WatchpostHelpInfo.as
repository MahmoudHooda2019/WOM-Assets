package wom.model.game.watchpost
{
   public class WatchpostHelpInfo
   {
      
      private var _helpedFriends:Vector.<WatchpostHelpedFriendDTO>;
      
      public function WatchpostHelpInfo(param1:Vector.<WatchpostHelpedFriendDTO>)
      {
         super();
         _helpedFriends = param1 ? param1 : new Vector.<WatchpostHelpedFriendDTO>();
      }
      
      public function get helpedFriends() : Vector.<WatchpostHelpedFriendDTO>
      {
         return _helpedFriends;
      }
   }
}

