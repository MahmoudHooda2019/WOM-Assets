package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import fl.controls.TextInput;
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceListColumnType;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.view.component.SearchTextInputNoIcon;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.button.colored.WomRedSmallButton;
   import wom.view.ui.common.ListHeaderView;
   import wom.view.util.PagingPanel;
   
   public class BrowseAllianceListPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private static const VIEWS_PER_PAGE:int = 5;
      
      private static const HEADER_HEIGHT:int = 22;
      
      public static const HEADER_WIDTH_RANK:int = 72;
      
      public static const HEADER_WIDTH_NAME:int = 185;
      
      public static const HEADER_WIDTH_MEMBERS:int = 73;
      
      public static const HEADER_WIDTH_SCORE:int = 55;
      
      public static const HEADER_WIDTH_MIN_SCORE:int = 76;
      
      public static const HEADER_WIDTH_MIN_LEVEL:int = 74;
      
      public static const HEADER_WIDTH_ACTIONS:int = 114;
      
      public static const HEADER_WIDTH_RANK_RANKING:int = 116;
      
      public static const HEADER_WIDTH_NAME_RANKING:int = 230;
      
      public static const HEADER_WIDTH_MEMBERS_RANKING:int = 140;
      
      public static const HEADER_WIDTH_SCORE_RANKING:int = 120;
      
      private var _headers:Vector.<ListHeaderView>;
      
      private var _sortedHeader:ListHeaderView;
      
      private var _headersEnabled:Boolean;
      
      private var _headerRank:ListHeaderView;
      
      private var _headerName:ListHeaderView;
      
      private var _headerMembers:ListHeaderView;
      
      private var _headerScore:ListHeaderView;
      
      private var _headerMinScore:ListHeaderView;
      
      private var _headerMinLevel:ListHeaderView;
      
      private var _headerActions:ListHeaderView;
      
      protected var _allianceViews:Vector.<BrowseAllianceView>;
      
      protected var _sortType:AllianceSortType;
      
      protected var _sortDirection:AllianceSortDirection;
      
      protected var _alliances:Vector.<AllianceDetailInfo>;
      
      protected var _lastPage:Boolean;
      
      private var _searchBackground:DisplayObject;
      
      private var _searchTextInput:TextInput;
      
      private var _searchButton:Button;
      
      private var _cancelSearchButton:Button;
      
      private var _createAllianceButton:WomButton;
      
      public function BrowseAllianceListPanel(param1:int = 665, param2:int = 443)
      {
         super(param1,param2);
         _sortType = AllianceSortType.RANK;
         _sortDirection = AllianceSortDirection.ASC;
         _alliances = new Vector.<AllianceDetailInfo>();
         _allianceViews = new Vector.<BrowseAllianceView>();
         _headersEnabled = true;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         createAllianceWindowSpecificFields();
         createHeaders();
         drawLayout();
      }
      
      protected function createAllianceWindowSpecificFields() : void
      {
         _searchBackground = assetRepository.getDisplayObject("BackgroundWhite");
         _searchBackground.width = 140;
         _searchBackground.height = 32;
         addChild(_searchBackground);
         _searchTextInput = new SearchTextInputNoIcon();
         _searchTextInput.width = 140;
         _searchTextInput.restrict = "A-Za-z0-9 _\\-şŞçÇğĞöÖüÜıİ";
         _searchTextInput.setStyle("textFormat",WomTextFormats.WOM_LIGHT_GREY_16);
         var _temp_3:* = _searchTextInput;
         var _loc1_:String = "ui.windows.alliance.browse.entername";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_searchTextInput);
         _searchButton = new WomBlueSmallButton();
         _searchButton.width = 32;
         _searchButton.setStyle("icon",assetRepository.getDisplayObject("IconSearch"));
         addChild(_searchButton);
         _cancelSearchButton = new WomRedSmallButton();
         _cancelSearchButton.width = 32;
         _cancelSearchButton.setStyle("icon",assetRepository.getDisplayObject("IconCancel"));
         _cancelSearchButton.visible = false;
         addChild(_cancelSearchButton);
         _createAllianceButton = new WomGreenSmallButton();
         _createAllianceButton.width = 174;
         var _temp_7:* = _createAllianceButton;
         var _loc2_:String = "ui.windows.alliance.createbutton";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _createAllianceButton.setStyle("icon",assetRepository.getDisplayObject("Gold27"));
         _createAllianceButton.rightLabel = (50).toString();
         addChild(_createAllianceButton);
      }
      
      override public function drawLayout() : void
      {
         drawHeaderRelatedLayout();
         drawAllianceViewsLayout();
         setPagingButtonsVisibility(_currentPageNumber);
         super.drawLayout();
      }
      
      protected function drawAllianceViewsLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _allianceViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_allianceViews[_loc1_],bg,0,_loc1_ * 71 + 77);
            _loc1_++;
         }
      }
      
      protected function drawHeaderRelatedLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_createAllianceButton,bg,bg.width - _createAllianceButton.width - 10,10);
         AlignmentUtil.alignAccordingToPositionOf(_searchBackground,bg,6,9);
         AlignmentUtil.alignAccordingToPositionOf(_searchTextInput,bg,6,9);
         AlignmentUtil.alignAccordingToPositionOf(_searchButton,bg,147,10);
         AlignmentUtil.alignRightOf(_cancelSearchButton,_searchButton,2);
         var _loc1_:int = 1;
         AlignmentUtil.alignAccordingToPositionOf(_headerRank,bg,5,52);
         AlignmentUtil.alignRightOf(_headerName,_headerRank,_loc1_);
         AlignmentUtil.alignRightOf(_headerMembers,_headerName,_loc1_);
         AlignmentUtil.alignRightOf(_headerScore,_headerMembers,_loc1_);
         AlignmentUtil.alignRightOf(_headerMinScore,_headerScore,_loc1_);
         AlignmentUtil.alignRightOf(_headerMinLevel,_headerMinScore,_loc1_);
         AlignmentUtil.alignRightOf(_headerActions,_headerMinLevel,_loc1_);
         updateSortingDirections();
      }
      
      protected function createHeaders() : void
      {
         _headers = new Vector.<ListHeaderView>();
         var _temp_3:* = §§findproperty(ListHeaderView);
         var _temp_2:* = true;
         var _loc1_:String = "ui.windows.alliance.browse.filter.rank";
         _headerRank = new ListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),72,22,AllianceListColumnType.RANK);
         addChild(_headerRank);
         _headers.push(_headerRank);
         var _temp_6:* = §§findproperty(ListHeaderView);
         var _temp_5:* = false;
         var _loc2_:String = "ui.windows.alliance.browse.filter.name";
         _headerName = new ListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc2_),185,22,AllianceListColumnType.NAME);
         addChild(_headerName);
         _headers.push(_headerName);
         var _temp_9:* = §§findproperty(ListHeaderView);
         var _temp_8:* = true;
         var _loc3_:String = "ui.windows.alliance.browse.filter.members";
         _headerMembers = new ListHeaderView(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),73,22,AllianceListColumnType.MEMBERS);
         addChild(_headerMembers);
         _headers.push(_headerMembers);
         var _temp_12:* = §§findproperty(ListHeaderView);
         var _temp_11:* = true;
         var _loc4_:String = "ui.windows.alliance.browse.filter.score";
         _headerScore = new ListHeaderView(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc4_),55,22,AllianceListColumnType.SCORE);
         addChild(_headerScore);
         _headers.push(_headerScore);
         var _temp_15:* = §§findproperty(ListHeaderView);
         var _temp_14:* = true;
         var _loc5_:String = "ui.windows.alliance.browse.filter.minscore";
         _headerMinScore = new ListHeaderView(_temp_14,peak.i18n.PText.INSTANCE.getText0(_loc5_),76,22,AllianceListColumnType.MIN_SCORE);
         addChild(_headerMinScore);
         _headers.push(_headerMinScore);
         var _temp_18:* = §§findproperty(ListHeaderView);
         var _temp_17:* = true;
         var _loc6_:String = "ui.windows.alliance.browse.filter.minlevel";
         _headerMinLevel = new ListHeaderView(_temp_17,peak.i18n.PText.INSTANCE.getText0(_loc6_),74,22,AllianceListColumnType.MIN_LEVEL);
         addChild(_headerMinLevel);
         _headers.push(_headerMinLevel);
         _headerActions = new ListHeaderView(false,"",114,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerActions);
         _headers.push(_headerActions);
         _sortedHeader = _headerRank;
      }
      
      protected function updateSortingDirections() : void
      {
         for each(var _loc1_ in _headers)
         {
            _loc1_.updateSortingDirection(0);
         }
         switch(_sortType)
         {
            case AllianceSortType.RANK:
               _sortedHeader = _headerRank;
               _headerRank.updateSortingDirection(_sortDirection == AllianceSortDirection.ASC ? 1 : -1);
               break;
            case AllianceSortType.BP:
               _sortedHeader = _headerScore;
               _headerScore.updateSortingDirection(_sortDirection == AllianceSortDirection.ASC ? 1 : -1);
               break;
            case AllianceSortType.MEMBER_COUNT:
               _sortedHeader = _headerMembers;
               _headerMembers.updateSortingDirection(_sortDirection == AllianceSortDirection.ASC ? 1 : -1);
               break;
            case AllianceSortType.MIN_SCORE:
               _sortedHeader = _headerMinScore;
               _headerMinScore.updateSortingDirection(_sortDirection == AllianceSortDirection.ASC ? 1 : -1);
               break;
            case AllianceSortType.MIN_LEVEL:
               _sortedHeader = _headerMinLevel;
               _headerMinLevel.updateSortingDirection(_sortDirection == AllianceSortDirection.ASC ? 1 : -1);
         }
      }
      
      override public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber > 0;
         _nextButton.visible = !_lastPage;
      }
      
      public function update(param1:AllianceSortType, param2:AllianceSortDirection, param3:Vector.<AllianceDetailInfo>, param4:AllianceSummaryInfo, param5:int, param6:Boolean, param7:Boolean = true, param8:int = 0) : void
      {
         var _loc10_:int = 0;
         var _loc9_:BrowseAllianceView = null;
         _sortType = param1;
         _sortDirection = param2;
         _alliances = param3;
         _currentPageNumber = param5;
         _lastPage = param6;
         _headersEnabled = param7;
         clearAll();
         _loc10_ = 0;
         while(_loc10_ < _alliances.length && _loc10_ < 5)
         {
            _loc9_ = new BrowseAllianceView(_alliances[_loc10_],param4,_loc10_ + 1);
            addChild(_loc9_);
            _allianceViews.push(_loc9_);
            _loc10_++;
         }
         drawLayout();
      }
      
      public function updateCreateButtonEnabling(param1:AllianceSummaryInfo) : void
      {
         _createAllianceButton.visible = param1 == null;
      }
      
      protected function clearAll() : void
      {
         for each(var _loc1_ in _allianceViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _allianceViews.length = 0;
      }
      
      public function searchTextInputClickedForTheFirstTime() : void
      {
         _searchTextInput.maxChars = 13;
         _searchTextInput.text = "";
         _searchTextInput.setStyle("textFormat",WomTextFormats.WOM_18);
      }
      
      public function updateSearchInputCase() : void
      {
         _searchTextInput.text = _searchTextInput.text.toUpperCase();
      }
      
      public function updateCancelSearchButtonVisibility(param1:Boolean) : void
      {
         _cancelSearchButton.visible = param1;
      }
      
      public function get headerRank() : ListHeaderView
      {
         return _headerRank;
      }
      
      public function get headerName() : ListHeaderView
      {
         return _headerName;
      }
      
      public function get headerMembers() : ListHeaderView
      {
         return _headerMembers;
      }
      
      public function get headerScore() : ListHeaderView
      {
         return _headerScore;
      }
      
      public function get headerMinScore() : ListHeaderView
      {
         return _headerMinScore;
      }
      
      public function get headerMinLevel() : ListHeaderView
      {
         return _headerMinLevel;
      }
      
      public function get searchButton() : Button
      {
         return _searchButton;
      }
      
      public function get createAllianceButton() : WomButton
      {
         return _createAllianceButton;
      }
      
      public function get searchTextInput() : TextInput
      {
         return _searchTextInput;
      }
      
      public function get cancelSearchButton() : Button
      {
         return _cancelSearchButton;
      }
      
      public function get sortType() : AllianceSortType
      {
         return _sortType;
      }
      
      public function get sortDirection() : AllianceSortDirection
      {
         return _sortDirection;
      }
      
      public function get sortedHeader() : ListHeaderView
      {
         return _sortedHeader;
      }
      
      public function get headersEnabled() : Boolean
      {
         return _headersEnabled;
      }
      
      public function get alliances() : Vector.<AllianceDetailInfo>
      {
         return _alliances;
      }
   }
}

