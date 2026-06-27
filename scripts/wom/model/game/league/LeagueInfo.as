package wom.model.game.league
{
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   
   public class LeagueInfo
   {
      
      private var _season:LeagueSeasonInfo;
      
      private var _levelDIO:LeagueLevelDIO;
      
      private var _members:Vector.<LeagueMemberInfo>;
      
      private var _rpReward:Boolean;
      
      private var _ratio:Number;
      
      public function LeagueInfo(param1:LeagueSeasonInfo, param2:LeagueLevelDIO, param3:Boolean, param4:Number)
      {
         super();
         _season = param1;
         _levelDIO = param2;
         _rpReward = param3;
         _ratio = param4;
         _members = new Vector.<LeagueMemberInfo>();
      }
      
      public function get season() : LeagueSeasonInfo
      {
         return _season;
      }
      
      public function get levelDIO() : LeagueLevelDIO
      {
         return _levelDIO;
      }
      
      public function get rpReward() : Boolean
      {
         return _rpReward;
      }
      
      public function get ratio() : Number
      {
         return _ratio;
      }
      
      public function get members() : Vector.<LeagueMemberInfo>
      {
         return _members;
      }
      
      public function set members(param1:Vector.<LeagueMemberInfo>) : void
      {
         _members = param1 != null ? param1 : new Vector.<LeagueMemberInfo>();
      }
   }
}

