package wom.model.game.rank
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class MobileRankingRow extends RankingRow
   {
      
      private var _rank:int;
      
      private var _visibleName:String;
      
      public function MobileRankingRow(param1:int, param2:Profile, param3:int, param4:Number, param5:AllianceSummaryInfo)
      {
         super(param2,param3,param4,param5);
         _rank = param1;
         _visibleName = null;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function set visibleName(param1:String) : void
      {
         _visibleName = param1;
      }
      
      public function get visibleName() : String
      {
         return _visibleName;
      }
   }
}

