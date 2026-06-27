package wom.model.game.friend
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   
   public interface FriendInfo
   {
      
      function get name() : String;
      
      function set name(param1:String) : void;
      
      function get profile() : Profile;
      
      function get coaInfo() : CoatOfArmsInfo;
      
      function set coaInfo(param1:CoatOfArmsInfo) : void;
      
      function get experiencePoints() : Number;
      
      function set experiencePoints(param1:Number) : void;
      
      function get searchAttr() : String;
   }
}

