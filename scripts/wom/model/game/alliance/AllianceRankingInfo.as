package wom.model.game.alliance
{
   public class AllianceRankingInfo
   {
      
      private var _sortType:AllianceSortType;
      
      private var _sortDirection:AllianceSortDirection;
      
      private var _pageOrder:int;
      
      private var _totalPageCount:int;
      
      private var _alliances:Vector.<AllianceDetailInfo>;
      
      private var _lastPage:Boolean;
      
      public function AllianceRankingInfo(param1:AllianceSortType, param2:AllianceSortDirection, param3:int, param4:int, param5:Vector.<AllianceDetailInfo>, param6:Boolean)
      {
         super();
         _sortType = param1;
         _sortDirection = param2;
         _pageOrder = param3;
         _totalPageCount = param4;
         _alliances = param5;
         _lastPage = param6;
      }
      
      public function get sortType() : AllianceSortType
      {
         return _sortType;
      }
      
      public function get sortDirection() : AllianceSortDirection
      {
         return _sortDirection;
      }
      
      public function get pageOrder() : int
      {
         return _pageOrder;
      }
      
      public function get totalPageCount() : int
      {
         return _totalPageCount;
      }
      
      public function get alliances() : Vector.<AllianceDetailInfo>
      {
         return _alliances;
      }
      
      public function get lastPage() : Boolean
      {
         return _lastPage;
      }
      
      public function getAlliance(param1:Number) : AllianceDetailInfo
      {
         if(_alliances == null)
         {
            return null;
         }
         for each(var _loc2_ in _alliances)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

