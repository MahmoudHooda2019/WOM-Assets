package wom.model.game.rank
{
   public class RankingInfo
   {
      
      private var _page:int;
      
      private var _totalPageCount:int;
      
      private var _rank:int;
      
      private var _firstRankInPage:int;
      
      private var _isLastPage:Boolean;
      
      private var _rankings:Vector.<RankingRow>;
      
      private var _rankedEntityType:RankedEntityType;
      
      private var _rankedEntityName:String;
      
      private var _sortCriteria:RankingSortCriteria;
      
      public function RankingInfo(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Vector.<RankingRow>, param7:RankedEntityType, param8:String, param9:RankingSortCriteria)
      {
         super();
         _page = param1;
         _totalPageCount = param2;
         _rank = param3;
         _firstRankInPage = param4;
         _isLastPage = param5;
         _rankings = param6;
         _rankedEntityType = param7;
         _rankedEntityName = param8;
         _sortCriteria = param9;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function get totalPageCount() : int
      {
         return _totalPageCount;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get firstRankInPage() : int
      {
         return _firstRankInPage;
      }
      
      public function get isLastPage() : Boolean
      {
         return _isLastPage;
      }
      
      public function get rankings() : Vector.<RankingRow>
      {
         return _rankings;
      }
      
      public function get rankedEntityType() : RankedEntityType
      {
         return _rankedEntityType;
      }
      
      public function get rankedEntityName() : String
      {
         return _rankedEntityName;
      }
      
      public function get sortCriteria() : RankingSortCriteria
      {
         return _sortCriteria;
      }
   }
}

