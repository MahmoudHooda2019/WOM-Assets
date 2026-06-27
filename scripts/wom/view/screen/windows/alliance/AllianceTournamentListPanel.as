package wom.view.screen.windows.alliance
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceListColumnType;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.ui.common.ListHeaderView;
   import wom.view.util.PagingPanel;
   
   public class AllianceTournamentListPanel extends PagingPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private static const VIEWS_PER_PAGE:int = 5;
      
      private static const HEADER_HEIGHT:int = 22;
      
      public static const HEADER_WIDTH_RANK:int = 88;
      
      public static const HEADER_WIDTH_NAME:int = 190;
      
      public static const HEADER_WIDTH_MEMBERS:int = 100;
      
      public static const HEADER_WIDTH_REWARD:int = 130;
      
      public static const HEADER_WIDTH_SCORE:int = 130;
      
      private var _sortType:AllianceSortType;
      
      private var _sortDirection:AllianceSortDirection;
      
      private var _headers:Vector.<ListHeaderView>;
      
      private var _headersEnabled:Boolean;
      
      private var _headerRank:ListHeaderView;
      
      private var _headerName:ListHeaderView;
      
      private var _headerMembers:ListHeaderView;
      
      private var _headerReward:ListHeaderView;
      
      private var _headerScore:ListHeaderView;
      
      private var _alliances:Vector.<AllianceDetailInfo>;
      
      private var _lastPage:Boolean;
      
      private var _totalPageCount:int;
      
      protected var _allianceViews:Vector.<AllianceTournamentView>;
      
      private var _warningTextField:TextField;
      
      public function AllianceTournamentListPanel(param1:int = 665, param2:int = 443)
      {
         super(param1,param2);
         _sortType = AllianceSortType.RANK;
         _sortDirection = AllianceSortDirection.ASC;
         _alliances = new Vector.<AllianceDetailInfo>();
         _allianceViews = new Vector.<AllianceTournamentView>();
         _headersEnabled = true;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         createHeaders();
         _warningTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _warningTextField.defaultTextFormat = WomTextFormats.CENTER_36;
         _warningTextField.width = 665;
         _warningTextField.autoSize = "center";
         _warningTextField.multiline = true;
         _warningTextField.wordWrap = true;
         _warningTextField.visible = false;
         addChild(_warningTextField);
         drawLayout();
      }
      
      private function createHeaders() : void
      {
         _headers = new Vector.<ListHeaderView>();
         var _temp_3:* = §§findproperty(ListHeaderView);
         var _temp_2:* = false;
         var _loc1_:String = "ui.windows.alliance.tournament.filter.rank";
         _headerRank = new ListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),88,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerRank);
         _headers.push(_headerRank);
         var _temp_6:* = §§findproperty(ListHeaderView);
         var _temp_5:* = false;
         var _loc2_:String = "ui.windows.alliance.tournament.filter.name";
         _headerName = new ListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc2_),190,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerName);
         _headers.push(_headerName);
         var _temp_9:* = §§findproperty(ListHeaderView);
         var _temp_8:* = false;
         var _loc3_:String = "ui.windows.alliance.tournament.filter.members";
         _headerMembers = new ListHeaderView(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),100,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerMembers);
         _headers.push(_headerMembers);
         var _temp_12:* = §§findproperty(ListHeaderView);
         var _temp_11:* = false;
         var _loc4_:String = "ui.windows.alliance.tournament.filter.reward";
         _headerReward = new ListHeaderView(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc4_),130,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerReward);
         _headers.push(_headerReward);
         var _temp_15:* = §§findproperty(ListHeaderView);
         var _temp_14:* = false;
         var _loc5_:String = "ui.windows.alliance.tournament.filter.score";
         _headerScore = new ListHeaderView(_temp_14,peak.i18n.PText.INSTANCE.getText0(_loc5_),130,22,AllianceListColumnType.UNSORTABLE);
         addChild(_headerScore);
         _headers.push(_headerScore);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_warningTextField,bg,160);
         drawHeaderRelatedLayout();
         drawAllianceViewsLayout();
         setPagingButtonsVisibility(_currentPageNumber);
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
         var _loc1_:int = 1;
         AlignmentUtil.alignAccordingToPositionOf(_headerRank,bg,10,52);
         AlignmentUtil.alignRightOf(_headerName,_headerRank,_loc1_);
         AlignmentUtil.alignRightOf(_headerMembers,_headerName,_loc1_);
         AlignmentUtil.alignRightOf(_headerReward,_headerMembers,_loc1_);
         AlignmentUtil.alignRightOf(_headerScore,_headerReward,_loc1_);
      }
      
      public function update(param1:Vector.<AllianceDetailInfo>, param2:AllianceSummaryInfo, param3:int, param4:Boolean, param5:int = 0) : void
      {
         var _loc7_:int = 0;
         var _loc6_:AllianceTournamentView = null;
         _alliances = param1;
         _currentPageNumber = param3;
         _lastPage = param4;
         _totalPageCount = param5;
         clearAll();
         if(_alliances.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _alliances.length && _loc7_ < 5)
            {
               _loc6_ = new AllianceTournamentView(_alliances[_loc7_],param2,_loc7_ + 1);
               addChild(_loc6_);
               _allianceViews.push(_loc6_);
               _loc7_++;
            }
         }
         drawLayout();
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
      
      override public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber > 1;
         _nextButton.visible = _currentPageNumber < _totalPageCount;
      }
      
      public function get alliances() : Vector.<AllianceDetailInfo>
      {
         return _alliances;
      }
      
      public function get totalPageCount() : int
      {
         return _totalPageCount;
      }
      
      public function setWarningText(param1:Boolean, param2:String) : void
      {
         _warningTextField.visible = param1;
         if(param1)
         {
            if(_warningTextField.text != param2)
            {
               _warningTextField.text = param2;
            }
         }
      }
   }
}

