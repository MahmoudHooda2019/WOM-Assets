package wom.model.game.league
{
   public class LeagueSeasonInfo
   {
      
      private var _remainingSeasonDuration:Number;
      
      public function LeagueSeasonInfo(param1:Number)
      {
         super();
         _remainingSeasonDuration = param1;
      }
      
      public function get remainingSeasonDuration() : Number
      {
         return _remainingSeasonDuration;
      }
      
      public function set remainingSeasonDuration(param1:Number) : void
      {
         _remainingSeasonDuration = param1;
      }
   }
}

