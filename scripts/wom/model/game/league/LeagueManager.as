package wom.model.game.league
{
   public class LeagueManager
   {
      
      private var _myLeague:LeagueInfo;
      
      public function LeagueManager()
      {
         super();
         _myLeague = null;
      }
      
      public function get myLeague() : LeagueInfo
      {
         return _myLeague;
      }
      
      public function set myLeague(param1:LeagueInfo) : void
      {
         _myLeague = param1;
      }
   }
}

