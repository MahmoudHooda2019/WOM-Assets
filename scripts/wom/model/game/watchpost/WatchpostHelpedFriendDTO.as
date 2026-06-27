package wom.model.game.watchpost
{
   import flash.utils.Dictionary;
   import wom.model.game.Profile;
   
   public class WatchpostHelpedFriendDTO
   {
      
      private var _friendProfile:Profile;
      
      private var _helpedUnits:Dictionary;
      
      public function WatchpostHelpedFriendDTO(param1:Profile, param2:Dictionary)
      {
         super();
         _friendProfile = param1;
         _helpedUnits = param2;
      }
      
      public function get friendProfile() : Profile
      {
         return _friendProfile;
      }
      
      public function get helpedUnits() : Dictionary
      {
         return _helpedUnits;
      }
   }
}

