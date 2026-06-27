package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceListColumnType;
   import wom.model.game.alliance.AllianceRankingInfo;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.rank.RankingInfo;
   import wom.view.screen.windows.rank.mobile.MobileBaseRankingPanel;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileLeaderboardBrowseAllianceListPanel extends MobileBaseRankingPanel
   {
      
      protected static const ALL_TIME_INDEX:int = 1;
      
      protected static const WEEKLY_INDEX:int = 2;
      
      protected static const DAILY_INDEX:int = 3;
      
      protected static const TOURNAMENT_INDEX:int = 0;
      
      private var _intervalCriterion:AllianceSortType;
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      private var _headers:Vector.<MobileListHeaderView>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      private var _headerRank:MobileListHeaderView;
      
      private var _headerName:MobileListHeaderView;
      
      private var _headerMembers:MobileListHeaderView;
      
      private var _headerScore:MobileListHeaderView;
      
      private var _headerActions:MobileListHeaderView;
      
      private var leftRoundHeaderFill:DisplayObject;
      
      private var rightRoundHeaderFill:DisplayObject;
      
      private var _tournamentListPanel:MobileAllianceTournamentListPanel;
      
      public function MobileLeaderboardBrowseAllianceListPanel()
      {
         super();
         _intervalCriterion = AllianceSortType.TOURNAMENT;
         _myAllianceSummary = null;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = _tabBar.dataProvider;
         var _loc1_:String = "ui.windows.rank.tournament";
         _temp_1.addItemAt(peak.i18n.PText.INSTANCE.getText0(_loc1_),0);
         _rankingList.height -= 33;
         createHeaders();
         updateHeaders();
      }
      
      override protected function alignList(param1:DisplayObject) : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_rankingList,param1,26,63);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         drawHeaderRelatedLayout();
      }
      
      protected function createHeaders() : void
      {
         _headers = new Vector.<MobileListHeaderView>();
         leftRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         leftRoundHeaderFill.width = 27;
         addChild(leftRoundHeaderFill);
         var _temp_4:* = §§findproperty(MobileListHeaderView);
         var _temp_3:* = false;
         var _loc1_:String = "ui.windows.alliance.browse.filter.rank";
         _headerRank = new MobileListHeaderView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc1_),118,AllianceListColumnType.UNSORTABLE);
         addChild(_headerRank);
         _headers.push(_headerRank);
         var _temp_7:* = §§findproperty(MobileListHeaderView);
         var _temp_6:* = false;
         var _loc2_:String = "ui.windows.alliance.browse.filter.name";
         _headerName = new MobileListHeaderView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),312,AllianceListColumnType.UNSORTABLE);
         addChild(_headerName);
         _headers.push(_headerName);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = false;
         var _loc3_:String = "ui.windows.alliance.browse.filter.members";
         _headerMembers = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc3_),145,AllianceListColumnType.UNSORTABLE);
         addChild(_headerMembers);
         _headers.push(_headerMembers);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = false;
         var _loc4_:String = "ui.windows.alliance.browse.filter.score";
         _headerScore = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc4_),165,AllianceListColumnType.UNSORTABLE);
         addChild(_headerScore);
         _headers.push(_headerScore);
         _headerActions = new MobileListHeaderView(false,"",203,AllianceListColumnType.UNSORTABLE);
         addChild(_headerActions);
         _headers.push(_headerActions);
         rightRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         rightRoundHeaderFill.width = 27;
         rightRoundHeaderFill.scaleX = -1;
         addChild(rightRoundHeaderFill);
         _sortedHeader = _headerRank;
      }
      
      protected function drawHeaderRelatedLayout() : void
      {
         var _loc1_:int = 0;
         leftRoundHeaderFill.y = 45;
         MobileAlignmentUtil.alignRightOf(_headerRank,leftRoundHeaderFill,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerName,_headerRank,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerMembers,_headerName,_loc1_);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_headerScore,_headerMembers,_loc1_,145);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_headerActions,_headerScore,_loc1_,165);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,_headerActions,_loc1_ + rightRoundHeaderFill.width);
      }
      
      override public function updateCriterion() : void
      {
         if(_tabBar && _tabBar.selectedIndex != -1)
         {
            _intervalCriterion = _tabBar.selectedIndex == 0 ? AllianceSortType.TOURNAMENT : (_tabBar.selectedIndex == 2 ? AllianceSortType.WEEKLY_BP : (_tabBar.selectedIndex == 3 ? AllianceSortType.DAILY_BP : AllianceSortType.BP));
         }
         else
         {
            _intervalCriterion = AllianceSortType.BP;
         }
         updateHeaders();
      }
      
      private function updateHeaders() : void
      {
         var _loc1_:Boolean = _intervalCriterion == AllianceSortType.TOURNAMENT;
         for each(var _loc2_ in _headers)
         {
            _loc2_.visible = !_loc1_;
         }
         leftRoundHeaderFill.visible = rightRoundHeaderFill.visible = !_loc1_;
         _rankingList.visible = !_loc1_;
         if(_tournamentListPanel == null)
         {
            _tournamentListPanel = new MobileAllianceTournamentListPanel(0,true);
            addChild(_tournamentListPanel);
         }
         _tournamentListPanel.visible = _loc1_;
      }
      
      override protected function rankingViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileBrowseAllianceViewRenderer = new MobileBrowseAllianceViewRenderer(assetRepository,_myAllianceSummary,true);
         _loc1_.width = _rankingList.width;
         _loc1_.height = 101;
         return _loc1_;
      }
      
      protected function updateSortingDirections() : void
      {
         for each(var _loc1_ in _headers)
         {
            _loc1_.updateSortingDirection(0);
         }
      }
      
      override public function rankingInfoUpdated(param1:RankingInfo) : void
      {
      }
      
      public function updateWithAlliances(param1:AllianceRankingInfo, param2:AllianceSummaryInfo) : void
      {
         _firstDataReceived = true;
         _currentPage = param1.pageOrder;
         _previousPageInfoTF.visible = _currentPage != 1;
         _nextPageInfoTF.visible = !param1.lastPage;
         _myAllianceSummary = param2;
         var _loc4_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc3_ in param1.alliances)
         {
            _loc4_.push({
               "alliance":_loc3_,
               "myAllianceExists":_myAllianceSummary != null
            });
         }
         _rankingList.dataProvider = new ListCollection(_loc4_);
         _rankingList.validate();
      }
      
      public function get intervalCriterion() : AllianceSortType
      {
         return _intervalCriterion;
      }
      
      public function get myAllianceSummary() : AllianceSummaryInfo
      {
         return _myAllianceSummary;
      }
      
      public function get myAllianceExists() : Boolean
      {
         return _myAllianceSummary != null;
      }
   }
}

