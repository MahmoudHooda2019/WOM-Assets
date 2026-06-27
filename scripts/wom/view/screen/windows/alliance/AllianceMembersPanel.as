package wom.view.screen.windows.alliance
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceMemberListColumnType;
   import wom.view.ui.common.ListHeaderView;
   import wom.view.util.LineUtil;
   import wom.view.util.PagingPanel;
   
   public class AllianceMembersPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 661;
      
      private static const HEIGHT:int = 378;
      
      private static const VIEWS_PER_PAGE:int = 5;
      
      protected static const HEADER_HEIGHT:int = 22;
      
      public static const HEADER_WIDTH_KEY_LEVEL:String = "level";
      
      public static const HEADER_WIDTH_KEY_NAME:String = "name";
      
      public static const HEADER_WIDTH_KEY_BATTLE_POINTS:String = "battle_points";
      
      public static const HEADER_WIDTH_KEY_ACTIONS:String = "actions";
      
      protected var headerWidths:Dictionary;
      
      protected var headers:Vector.<ListHeaderView>;
      
      private var _sortedHeader:ListHeaderView;
      
      private var _headerLevel:ListHeaderView;
      
      private var _headerName:ListHeaderView;
      
      protected var _headerBattlePoints:ListHeaderView;
      
      protected var headerActions:ListHeaderView;
      
      private var _memberViews:Vector.<AllianceMemberView>;
      
      private var _members:Vector.<AllianceMemberInfo>;
      
      public function AllianceMembersPanel()
      {
         super(661,378);
         _members = new Vector.<AllianceMemberInfo>();
         _memberViews = new Vector.<AllianceMemberView>();
         headerWidths = new Dictionary();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         LineUtil.drawHorizontalSeparatorLine(this,0,661);
         createHeaders();
         initHeaders(_headerBattlePoints);
         LineUtil.drawHorizontalSeparatorLine(this,0,661,null,null,28);
         drawLayout();
      }
      
      protected function alignHeaders() : void
      {
         var _loc1_:int = 1;
         AlignmentUtil.alignAccordingToPositionOf(_headerLevel,bg,3,4);
         AlignmentUtil.alignRightOf(_headerName,_headerLevel,_loc1_);
         AlignmentUtil.alignRightOf(_headerBattlePoints,_headerName,_loc1_);
         AlignmentUtil.alignRightOf(headerActions,_headerBattlePoints,_loc1_);
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         alignHeaders();
         _loc1_ = 0;
         while(_loc1_ < _memberViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_memberViews[_loc1_],bg,0,_loc1_ * 70 + 30);
            _loc1_++;
         }
         setPagingButtonsVisibility(_currentPageNumber);
         super.drawLayout();
      }
      
      protected function initHeaderWidths() : void
      {
         headerWidths["level"] = 115;
         headerWidths["name"] = 205;
         headerWidths["battle_points"] = 205;
         headerWidths["actions"] = 127;
      }
      
      protected function createHeaders() : void
      {
         initHeaderWidths();
         headers = new Vector.<ListHeaderView>();
         var _temp_3:* = §§findproperty(ListHeaderView);
         var _temp_2:* = true;
         var _loc1_:String = "ui.windows.alliance.members.filter.level";
         _headerLevel = new ListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),headerWidths["level"],22,AllianceMemberListColumnType.LEVEL);
         addChild(_headerLevel);
         headers.push(_headerLevel);
         var _temp_6:* = §§findproperty(ListHeaderView);
         var _temp_5:* = true;
         var _loc2_:String = "ui.windows.alliance.members.filter.name";
         _headerName = new ListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc2_),headerWidths["name"],22,AllianceMemberListColumnType.NAME);
         addChild(_headerName);
         headers.push(_headerName);
         var _temp_9:* = §§findproperty(ListHeaderView);
         var _temp_8:* = true;
         var _loc3_:String = "ui.windows.alliance.members.filter.battlepoints";
         _headerBattlePoints = new ListHeaderView(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),headerWidths["battle_points"],22,AllianceMemberListColumnType.BATTLE_POINTS);
         addChild(_headerBattlePoints);
         headers.push(_headerBattlePoints);
         var _temp_12:* = §§findproperty(ListHeaderView);
         var _temp_11:* = false;
         var _loc4_:String = "ui.windows.alliance.members.filter.actions";
         headerActions = new ListHeaderView(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc4_),headerWidths["actions"],22,AllianceMemberListColumnType.UNSORTABLE);
         addChild(headerActions);
         headers.push(headerActions);
      }
      
      protected function initSort() : void
      {
         _members.sort(AllianceMemberListColumnType.BATTLE_POINTS_LEADER_FIRST.dscComperator);
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
      
      public function updateWithMembers(param1:Vector.<AllianceMemberInfo>, param2:int) : void
      {
         _members = param1;
         initHeaders(_headerBattlePoints);
         update(param2);
      }
      
      public function update(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:AllianceMemberView = null;
         _currentPageNumber = param1;
         clearAll();
         var _loc2_:int = _currentPageNumber * 5;
         var _loc3_:int = _loc2_ + 5;
         _loc5_ = _loc2_;
         while(_loc5_ < _loc3_ && _loc5_ < _members.length)
         {
            _loc4_ = new AllianceMemberView(_members[_loc5_],headerWidths,_loc5_ + 1,_members[_loc5_].type);
            addChild(_loc4_);
            _memberViews.push(_loc4_);
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
      
      public function get headerLevel() : ListHeaderView
      {
         return _headerLevel;
      }
      
      public function get headerName() : ListHeaderView
      {
         return _headerName;
      }
      
      public function get headerBattlePoints() : ListHeaderView
      {
         return _headerBattlePoints;
      }
      
      public function get members() : Vector.<AllianceMemberInfo>
      {
         return _members;
      }
      
      public function get sortedHeader() : ListHeaderView
      {
         return _sortedHeader;
      }
   }
}

