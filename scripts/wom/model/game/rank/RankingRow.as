package wom.model.game.rank
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class RankingRow
   {
      
      private var _profile:Profile;
      
      private var _level:int;
      
      private var _score:Number;
      
      private var _alliance:AllianceSummaryInfo;
      
      public function RankingRow(param1:Profile, param2:int, param3:Number, param4:AllianceSummaryInfo)
      {
         super();
         _profile = param1;
         _level = param2;
         _score = param3;
         _alliance = param4;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get score() : Number
      {
         return _score;
      }
      
      public function get alliance() : AllianceSummaryInfo
      {
         return _alliance;
      }
   }
}

