package wom.model.game.friend
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   
   public class DefaultFriendInfo implements FriendInfo
   {
      
      private var _name:String;
      
      private var _profile:Profile;
      
      private var _experiencePoints:Number;
      
      private var _coaInfo:CoatOfArmsInfo;
      
      private var _searchAttr:String;
      
      public function DefaultFriendInfo(param1:String, param2:Profile, param3:CoatOfArmsInfo = null)
      {
         super();
         _profile = param2;
         _coaInfo = param3;
         _experiencePoints = -1;
         _name = determineName(param1);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         if(param1 != null)
         {
            _name = param1;
            if(_searchAttr)
            {
               _searchAttr = _name.toLowerCase();
            }
         }
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get coaInfo() : CoatOfArmsInfo
      {
         return _coaInfo;
      }
      
      public function set coaInfo(param1:CoatOfArmsInfo) : void
      {
         _coaInfo = param1;
      }
      
      public function get experiencePoints() : Number
      {
         return _experiencePoints;
      }
      
      public function set experiencePoints(param1:Number) : void
      {
         _experiencePoints = param1;
      }
      
      private function determineName(param1:String) : String
      {
         if(param1 != null)
         {
            return param1;
         }
         if(_profile != null)
         {
            if(_profile.gameId != null)
            {
               return _profile.gameId;
            }
            if(_profile.platformId != null)
            {
               return _profile.platformId;
            }
            return "Friend";
         }
         return "Friend";
      }
      
      public function get searchAttr() : String
      {
         if(_searchAttr)
         {
            return _searchAttr;
         }
         if(_name)
         {
            _searchAttr = _name.toLowerCase();
            return _searchAttr;
         }
         return "";
      }
   }
}

