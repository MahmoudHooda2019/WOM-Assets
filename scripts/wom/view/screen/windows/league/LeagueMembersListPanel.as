package wom.view.screen.windows.league
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.Profile;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.game.league.LeagueMembersListColumnType;
   import wom.view.ui.common.ListHeaderView;
   import wom.view.util.PagingPanel;
   
   public class LeagueMembersListPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 370;
      
      private static const VIEWS_PER_PAGE:int = 5;
      
      protected static const HEADER_HEIGHT:int = 22;
      
      public static const HEADER_WIDTH_KEY_RANK:String = "rank";
      
      public static const HEADER_WIDTH_KEY_LEVEL:String = "level";
      
      public static const HEADER_WIDTH_KEY_ALLIANCE:String = "alliance";
      
      public static const HEADER_WIDTH_KEY_NAME:String = "name";
      
      public static const HEADER_WIDTH_KEY_HISTORY:String = "history";
      
      public static const HEADER_WIDTH_KEY_BATTLE_POINTS:String = "battle_points";
      
      protected var headerWidths:Dictionary;
      
      protected var headers:Vector.<ListHeaderView>;
      
      private var _sortedHeader:ListHeaderView;
      
      private var _headerRank:ListHeaderView;
      
      private var _headerLevel:ListHeaderView;
      
      private var _headerAlliance:ListHeaderView;
      
      private var _headerName:ListHeaderView;
      
      private var _headerHistory:ListHeaderView;
      
      private var _headerBattlePoints:ListHeaderView;
      
      private var _memberViews:Vector.<LeagueMemberView>;
      
      private var _members:Vector.<LeagueMemberInfo>;
      
      private var _me:Profile;
      
      public function LeagueMembersListPanel()
      {
         super(603,370);
         _members = new Vector.<LeagueMemberInfo>();
         _memberViews = new Vector.<LeagueMemberView>();
         headerWidths = new Dictionary();
         _me = null;
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         createHeaders();
         initHeaders(_headerRank);
         drawLayout();
      }
      
      protected function alignHeaders() : void
      {
         var _loc1_:int = 1;
         AlignmentUtil.alignAccordingToPositionOf(_headerRank,bg,2,0);
         AlignmentUtil.alignRightOf(_headerLevel,_headerRank,_loc1_);
         AlignmentUtil.alignRightOf(_headerAlliance,_headerLevel,_loc1_);
         AlignmentUtil.alignRightOf(_headerName,_headerAlliance,_loc1_);
         AlignmentUtil.alignRightOf(_headerHistory,_headerName,_loc1_);
         AlignmentUtil.alignRightOf(_headerBattlePoints,_headerHistory,_loc1_);
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         alignHeaders();
         _loc1_ = 0;
         while(_loc1_ < _memberViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_memberViews[_loc1_],bg,0,_loc1_ * 70 + 20);
            _loc1_++;
         }
         setPagingButtonsVisibility(_currentPageNumber);
         super.drawLayout();
      }
      
      protected function initHeaderWidths() : void
      {
         headerWidths["rank"] = 78;
         headerWidths["level"] = 69;
         headerWidths["alliance"] = 73;
         headerWidths["name"] = 145;
         headerWidths["history"] = 143;
         headerWidths["battle_points"] = 86;
      }
      
      protected function createHeaders() : void
      {
         initHeaderWidths();
         headers = new Vector.<ListHeaderView>();
         var _temp_3:* = §§findproperty(ListHeaderView);
         var _temp_2:* = true;
         var _loc1_:String = "ui.windows.league.list.headers.rank";
         _headerRank = new ListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),headerWidths["rank"],22,LeagueMembersListColumnType.RANK);
         addChild(_headerRank);
         headers.push(_headerRank);
         var _temp_6:* = §§findproperty(ListHeaderView);
         var _temp_5:* = true;
         var _loc2_:String = "ui.windows.league.list.headers.level";
         _headerLevel = new ListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc2_),headerWidths["level"],22,LeagueMembersListColumnType.LEVEL);
         addChild(_headerLevel);
         headers.push(_headerLevel);
         var _temp_9:* = §§findproperty(ListHeaderView);
         var _temp_8:* = true;
         var _loc3_:String = "ui.windows.league.list.headers.alliance";
         _headerAlliance = new ListHeaderView(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),headerWidths["alliance"],22,LeagueMembersListColumnType.ALLIANCE);
         addChild(_headerAlliance);
         headers.push(_headerAlliance);
         var _temp_12:* = §§findproperty(ListHeaderView);
         var _temp_11:* = true;
         var _loc4_:String = "ui.windows.league.list.headers.name";
         _headerName = new ListHeaderView(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc4_),headerWidths["name"],22,LeagueMembersListColumnType.NAME);
         addChild(_headerName);
         headers.push(_headerName);
         var _temp_15:* = §§findproperty(ListHeaderView);
         var _temp_14:* = false;
         var _loc5_:String = "ui.windows.league.list.headers.history";
         _headerHistory = new ListHeaderView(_temp_14,peak.i18n.PText.INSTANCE.getText0(_loc5_),headerWidths["history"],22,LeagueMembersListColumnType.UNSORTABLE);
         addChild(_headerHistory);
         headers.push(_headerHistory);
         var _temp_18:* = §§findproperty(ListHeaderView);
         var _temp_17:* = true;
         var _loc6_:String = "ui.windows.league.list.headers.points";
         _headerBattlePoints = new ListHeaderView(_temp_17,peak.i18n.PText.INSTANCE.getText0(_loc6_),headerWidths["battle_points"],22,LeagueMembersListColumnType.BATTLE_POINTS);
         addChild(_headerBattlePoints);
         headers.push(_headerBattlePoints);
      }
      
      protected function initSort() : void
      {
         _members.sort(LeagueMembersListColumnType.RANK.ascComperator);
      }
      
      public function initHeaders(param1:ListHeaderView) : void
      {
         for each(var _loc2_ in headers)
         {
            _loc2_.updateSortingDirection(0);
         }
         _sortedHeader = param1;
         initSort();
      }
      
      override public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber > 0;
         _nextButton.visible = _members.length > _currentPageNumber * 5 + 5;
      }
      
      public function updateWithMembers(param1:Vector.<LeagueMemberInfo>, param2:Profile) : void
      {
         var _loc4_:int = 0;
         _members = param1;
         _me = param2;
         initHeaders(_headerBattlePoints);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _members.length)
         {
            if(_members[_loc4_].profile.gameId == param2.gameId)
            {
               _loc3_ = Math.floor(_loc4_ / 5);
               break;
            }
            _loc4_++;
         }
         update(_loc3_);
      }
      
      public function update(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:LeagueMemberView = null;
         _currentPageNumber = param1;
         clearAll();
         var _loc3_:int = _currentPageNumber * 5;
         var _loc4_:int = _loc3_ + 5;
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_ && _loc5_ < _members.length)
         {
            _loc2_ = new LeagueMemberView(_members[_loc5_],headerWidths,_loc5_ + 1,_me != null && _members[_loc5_].profile.gameId == _me.gameId);
            addChild(_loc2_);
            _memberViews.push(_loc2_);
            _loc5_++;
         }
         drawLayout();
      }
      
      private function clearAll() : void
      {
         for each(var _loc1_ in _memberViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _memberViews.length = 0;
      }
      
      public function updateAccordingToSorting(param1:int = 0) : void
      {
         _members.sort(_sortedHeader.getComperatorFunction());
         update(param1);
      }
      
      public function headerClicked(param1:ListHeaderView) : void
      {
         for each(var _loc2_ in headers)
         {
            if(_loc2_ == param1)
            {
               if(_loc2_.sortingDirection == 1)
               {
                  _loc2_.updateSortingDirection(-1);
               }
               else if(_loc2_.sortingDirection == -1)
               {
                  _loc2_.updateSortingDirection(1);
               }
               else
               {
                  _loc2_.updateSortingDirection(1);
               }
            }
            else
            {
               _loc2_.updateSortingDirection(0);
            }
         }
         _sortedHeader = param1;
         updateAccordingToSorting();
      }
      
      public function get headerRank() : ListHeaderView
      {
         return _headerRank;
      }
      
      public function get headerLevel() : ListHeaderView
      {
         return _headerLevel;
      }
      
      public function get headerAlliance() : ListHeaderView
      {
         return _headerAlliance;
      }
      
      public function get headerName() : ListHeaderView
      {
         return _headerName;
      }
      
      public function get headerBattlePoints() : ListHeaderView
      {
         return _headerBattlePoints;
      }
      
      public function get members() : Vector.<LeagueMemberInfo>
      {
         return _members;
      }
      
      public function get sortedHeader() : ListHeaderView
      {
         return _sortedHeader;
      }
   }
}

