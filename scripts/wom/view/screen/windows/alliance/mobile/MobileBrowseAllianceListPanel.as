package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.supportClasses.IViewPort;
   import feathers.data.ListCollection;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPTextInput;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceListColumnType;
   import wom.model.game.alliance.AllianceRankingInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileBrowseAllianceListPanel extends Sprite
   {
      
      public static const HEADER_WIDTH_RANK:int = 109;
      
      public static const HEADER_WIDTH_NAME:int = 215;
      
      public static const HEADER_WIDTH_MEMBERS:int = 94;
      
      public static const HEADER_WIDTH_SCORE:int = 85;
      
      public static const HEADER_WIDTH_MIN_SCORE:int = 86;
      
      public static const HEADER_WIDTH_MIN_LEVEL:int = 95;
      
      public static const HEADER_WIDTH_ACTIONS:int = 260;
      
      public static const HEADER_WIDTH_RANK_RANKING:int = 118;
      
      public static const HEADER_WIDTH_NAME_RANKING:int = 312;
      
      public static const HEADER_WIDTH_MEMBERS_RANKING:int = 145;
      
      public static const HEADER_WIDTH_SCORE_RANKING:int = 165;
      
      public static const HEADER_WIDTH_ACTIONS_RANKING:int = 203;
      
      private static const PAGE_REQUEST_PULL_MARGIN:int = 120;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _headers:Vector.<MobileListHeaderView>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      private var _headersEnabled:Boolean;
      
      private var _headerRank:MobileListHeaderView;
      
      private var _headerName:MobileListHeaderView;
      
      private var _headerMembers:MobileListHeaderView;
      
      private var _headerScore:MobileListHeaderView;
      
      private var _headerMinScore:MobileListHeaderView;
      
      private var _headerMinLevel:MobileListHeaderView;
      
      private var _headerActions:MobileListHeaderView;
      
      private var leftRoundHeaderFill:DisplayObject;
      
      private var rightRoundHeaderFill:DisplayObject;
      
      private var _allianceList:MPList;
      
      protected var _previousPageInfoTF:MobileWomTextField;
      
      protected var _nextPageInfoTF:MobileWomTextField;
      
      protected var _sortType:AllianceSortType;
      
      protected var _sortDirection:AllianceSortDirection;
      
      protected var _alliances:Vector.<AllianceDetailInfo>;
      
      private var _searchBackground:DisplayObject;
      
      private var _searchTextInput:MPTextInput;
      
      private var _searchButton:MPButton;
      
      private var _cancelSearchButton:MPButton;
      
      private var _createAllianceButton:MobileWomButton;
      
      private var _widthDifference:int;
      
      private var _currentPage:int;
      
      private var _firstDataReceived:Boolean;
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      public function MobileBrowseAllianceListPanel(param1:int)
      {
         super();
         _sortType = AllianceSortType.RANK;
         _sortDirection = AllianceSortDirection.ASC;
         _alliances = new Vector.<AllianceDetailInfo>();
         _headersEnabled = true;
         _widthDifference = param1;
         _myAllianceSummary = null;
         _currentPage = 1;
         _firstDataReceived = false;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         createAllianceWindowSpecificFields();
         createHeaders();
      }
      
      protected function createAllianceWindowSpecificFields() : void
      {
         _searchBackground = assetRepository.getDisplayObject("MobileInnerBeigeBackground");
         _searchBackground.width = 999 + _widthDifference;
         _searchBackground.height = 85;
         addChild(_searchBackground);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         _loc1_.width = 999 + _widthDifference;
         _loc1_.height = 576;
         _loc1_.y = 96;
         addChild(_loc1_);
         _searchTextInput = new MobileWomTextInput();
         _searchTextInput.width = 455;
         _searchTextInput.maxChars = 13;
         _searchTextInput.restrict = "A-Za-z0-9 _\\-şŞçÇğĞöÖüÜıİ";
         addChild(_searchTextInput);
         _searchTextInput.promptProperties.textFormat = getWomTextFormat(30,"left",8882055);
         var _temp_3:* = _searchTextInput;
         var _loc3_:String = "ui.windows.alliance.browse.entername";
         _temp_3.prompt = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _searchButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _searchButton.width = 71;
         _searchButton.defaultIcon = assetRepository.getDisplayObject("SymbolSearch");
         addChild(_searchButton);
         _cancelSearchButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _cancelSearchButton.width = 71;
         _cancelSearchButton.label = "X";
         _cancelSearchButton.visible = false;
         addChild(_cancelSearchButton);
         var _loc2_:int = 948;
         _previousPageInfoTF = new MobileCaptionTextField();
         _previousPageInfoTF.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         _previousPageInfoTF.width = _loc2_;
         addChild(_previousPageInfoTF);
         _nextPageInfoTF = new MobileCaptionTextField();
         _nextPageInfoTF.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         _nextPageInfoTF.width = _loc2_;
         addChild(_nextPageInfoTF);
         _allianceList = new MPList();
         _allianceList.itemRendererFactory = browseAllianceRendererFactory;
         _allianceList.x = 26 + (_widthDifference >> 1);
         _allianceList.y = 164;
         _allianceList.height = 500;
         _allianceList.width = _loc2_;
         addChild(_allianceList);
         _createAllianceButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _createAllianceButton.width = 250;
         var _temp_10:* = _createAllianceButton;
         var _loc4_:String = "ui.windows.alliance.createbutton";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _createAllianceButton.defaultIcon = assetRepository.getDisplayObject("IconGoldS");
         _createAllianceButton.rightLabel = (50).toString();
         addChild(_createAllianceButton);
      }
      
      private function browseAllianceRendererFactory() : MPItemRenderer
      {
         var _loc1_:MobileBrowseAllianceViewRenderer = new MobileBrowseAllianceViewRenderer(assetRepository,_myAllianceSummary,false);
         _loc1_.width = _allianceList.width;
         _loc1_.height = 104;
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         drawHeaderRelatedLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(_previousPageInfoTF,_allianceList,0,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_nextPageInfoTF,_allianceList,0,_allianceList.height - 45);
      }
      
      protected function drawHeaderRelatedLayout() : void
      {
         _createAllianceButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_createAllianceButton,_searchBackground,_searchBackground.width - _createAllianceButton.width - 20);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchTextInput,_searchBackground,11);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchButton,_searchBackground,446);
         MobileAlignmentUtil.alignRightOf(_cancelSearchButton,_searchButton,5);
         var _loc1_:int = 0;
         leftRoundHeaderFill.y = 96;
         MobileAlignmentUtil.alignRightOf(_headerRank,leftRoundHeaderFill,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerName,_headerRank,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerMembers,_headerName,_loc1_);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_headerScore,_headerMembers,_loc1_,94);
         MobileAlignmentUtil.alignRightOf(_headerMinScore,_headerScore,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerMinLevel,_headerMinScore,_loc1_);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_headerActions,_headerMinLevel,_loc1_,95);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,_headerActions,_loc1_ + rightRoundHeaderFill.width);
         updateSortingDirections();
      }
      
      protected function createHeaders() : void
      {
         _headers = new Vector.<MobileListHeaderView>();
         leftRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         leftRoundHeaderFill.width = 27 + (_widthDifference >> 1);
         addChild(leftRoundHeaderFill);
         var _temp_4:* = §§findproperty(MobileListHeaderView);
         var _temp_3:* = true;
         var _loc1_:String = "ui.windows.alliance.browse.filter.rank";
         _headerRank = new MobileListHeaderView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc1_),109,AllianceListColumnType.RANK);
         addChild(_headerRank);
         _headers.push(_headerRank);
         var _temp_7:* = §§findproperty(MobileListHeaderView);
         var _temp_6:* = false;
         var _loc2_:String = "ui.windows.alliance.browse.filter.name";
         _headerName = new MobileListHeaderView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),215,AllianceListColumnType.NAME);
         addChild(_headerName);
         _headers.push(_headerName);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = true;
         var _loc3_:String = "ui.windows.alliance.browse.filter.members";
         _headerMembers = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc3_),94,AllianceListColumnType.MEMBERS);
         addChild(_headerMembers);
         _headers.push(_headerMembers);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = true;
         var _loc4_:String = "ui.windows.alliance.browse.filter.score";
         _headerScore = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc4_),85,AllianceListColumnType.SCORE);
         addChild(_headerScore);
         _headers.push(_headerScore);
         var _temp_16:* = §§findproperty(MobileListHeaderView);
         var _temp_15:* = true;
         var _loc5_:String = "ui.windows.alliance.browse.filter.minscore";
         _headerMinScore = new MobileListHeaderView(_temp_15,peak.i18n.PText.INSTANCE.getText0(_loc5_),86,AllianceListColumnType.MIN_SCORE);
         addChild(_headerMinScore);
         _headers.push(_headerMinScore);
         var _temp_19:* = §§findproperty(MobileListHeaderView);
         var _temp_18:* = true;
         var _loc6_:String = "ui.windows.alliance.browse.filter.minlevel";
         _headerMinLevel = new MobileListHeaderView(_temp_18,peak.i18n.PText.INSTANCE.getText0(_loc6_),95,AllianceListColumnType.MIN_LEVEL);
         addChild(_headerMinLevel);
         _headers.push(_headerMinLevel);
         _headerActions = new MobileListHeaderView(false,"",260,AllianceListColumnType.UNSORTABLE);
         addChild(_headerActions);
         _headers.push(_headerActions);
         rightRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         rightRoundHeaderFill.width = 27 + (_widthDifference >> 1);
         rightRoundHeaderFill.scaleX = -1;
         addChild(rightRoundHeaderFill);
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
      
      public function update(param1:AllianceRankingInfo, param2:Boolean = true) : void
      {
         _sortType = param1.sortType;
         _sortDirection = param1.sortDirection;
         _alliances = param1.alliances;
         _headersEnabled = param2;
         _currentPage = param1.pageOrder;
         _firstDataReceived = true;
         _previousPageInfoTF.visible = param2 && _currentPage != 1;
         _nextPageInfoTF.visible = param2 && !param1.lastPage;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc3_ in _alliances)
         {
            _loc4_.push({
               "alliance":_loc3_,
               "myAllianceExists":_myAllianceSummary != null
            });
         }
         _allianceList.dataProvider = new ListCollection(_loc4_);
         _allianceList.validate();
         drawLayout();
      }
      
      public function updateCreateButtonEnabling(param1:AllianceSummaryInfo) : void
      {
         _createAllianceButton.visible = param1 == null;
         _myAllianceSummary = param1;
      }
      
      public function updateSearchInputCase() : void
      {
         _searchTextInput.text = _searchTextInput.text.toUpperCase();
      }
      
      public function updateCancelSearchButtonVisibility(param1:Boolean) : void
      {
         _cancelSearchButton.visible = param1;
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         _searchTextInput.isFocusEnabled = _searchTextInput.isEnabled = _searchTextInput.visible = param1;
      }
      
      public function checkNextPageRequestConditions() : Boolean
      {
         var _loc2_:IViewPort = null;
         var _loc1_:Number = NaN;
         if(_allianceList && _allianceList.viewPort && _allianceList.dataProvider)
         {
            _loc2_ = _allianceList.viewPort;
            _loc1_ = _loc2_.verticalScrollPosition - _allianceList.dataProvider.length * _loc2_.verticalScrollStep + _allianceList.height;
            if(_loc1_ > 120)
            {
               var _temp_3:* = _nextPageInfoTF;
               var _loc3_:String = "m.ui.windows.leaderboard.releasefornextpage";
               _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               return true;
            }
         }
         return false;
      }
      
      public function checkPreviousPageRequestConditions() : Boolean
      {
         var _loc1_:IViewPort = null;
         if(_allianceList && _allianceList.viewPort && _allianceList.dataProvider)
         {
            _loc1_ = _allianceList.viewPort;
            if(_loc1_.verticalScrollPosition < -120)
            {
               var _temp_3:* = _previousPageInfoTF;
               var _loc2_:String = "m.ui.windows.leaderboard.releaseforpreviouspage";
               _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               return true;
            }
         }
         return false;
      }
      
      public function scrollCompleted() : void
      {
         var _temp_1:* = _previousPageInfoTF;
         var _loc1_:String = "m.ui.windows.leaderboard.pullforpreviouspage";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _temp_2:* = _nextPageInfoTF;
         var _loc2_:String = "m.ui.windows.leaderboard.pullfornextpage";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      public function get headerRank() : MobileListHeaderView
      {
         return _headerRank;
      }
      
      public function get headerName() : MobileListHeaderView
      {
         return _headerName;
      }
      
      public function get headerMembers() : MobileListHeaderView
      {
         return _headerMembers;
      }
      
      public function get headerScore() : MobileListHeaderView
      {
         return _headerScore;
      }
      
      public function get headerMinScore() : MobileListHeaderView
      {
         return _headerMinScore;
      }
      
      public function get headerMinLevel() : MobileListHeaderView
      {
         return _headerMinLevel;
      }
      
      public function get searchButton() : MPButton
      {
         return _searchButton;
      }
      
      public function get createAllianceButton() : MPButton
      {
         return _createAllianceButton;
      }
      
      public function get searchTextInput() : MPTextInput
      {
         return _searchTextInput;
      }
      
      public function get cancelSearchButton() : MPButton
      {
         return _cancelSearchButton;
      }
      
      public function get sortDirection() : AllianceSortDirection
      {
         return _sortDirection;
      }
      
      public function get sortedHeader() : MobileListHeaderView
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
      
      public function get allianceList() : MPList
      {
         return _allianceList;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get firstDataReceived() : Boolean
      {
         return _firstDataReceived;
      }
   }
}

