package wom.view.screen.windows.league.mobile
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.Profile;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.game.league.LeagueMembersListColumnType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileLeagueMembersListPanel extends Sprite
   {
      
      private static const WIDTH:int = 999;
      
      private static const HEIGHT:int = 548;
      
      public static const HEADER_WIDTH_KEY_RANK:String = "rank";
      
      public static const HEADER_WIDTH_KEY_LEVEL:String = "level";
      
      public static const HEADER_WIDTH_KEY_ALLIANCE:String = "alliance";
      
      public static const HEADER_WIDTH_KEY_NAME:String = "name";
      
      public static const HEADER_WIDTH_KEY_HISTORY:String = "history";
      
      public static const HEADER_WIDTH_KEY_BATTLE_POINTS:String = "battle_points";
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var headerWidths:Dictionary;
      
      protected var headers:Vector.<MobileListHeaderView>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      private var _headerRank:MobileListHeaderView;
      
      private var _headerLevel:MobileListHeaderView;
      
      private var _headerAlliance:MobileListHeaderView;
      
      private var _headerName:MobileListHeaderView;
      
      private var _headerHistory:MobileListHeaderView;
      
      private var _headerBattlePoints:MobileListHeaderView;
      
      private var rightRoundHeaderFill:DisplayObject;
      
      private var _memberList:MPList;
      
      private var _members:Vector.<LeagueMemberInfo>;
      
      private var _me:Profile;
      
      public function MobileLeagueMembersListPanel()
      {
         super();
         _members = new Vector.<LeagueMemberInfo>();
         headerWidths = new Dictionary();
         _me = null;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         _loc1_.width = 999;
         _loc1_.height = 548;
         addChild(_loc1_);
         createHeaders();
         initHeaders(_headerRank);
         _memberList = new MPList();
         _memberList.itemRendererFactory = leagueMemberRendererFactory;
         _memberList.x = 26;
         _memberList.y = 67;
         _memberList.height = 468;
         _memberList.width = 948;
         addChild(_memberList);
      }
      
      private function leagueMemberRendererFactory() : MPItemRenderer
      {
         var _loc1_:MobileLeagueMemberRenderer = new MobileLeagueMemberRenderer(assetRepository,headerWidths,_me.gameId);
         _loc1_.width = _memberList.width;
         _loc1_.height = 104;
         return _loc1_;
      }
      
      protected function alignHeaders() : void
      {
         var _loc1_:int = 1;
         _headerRank.x = 28;
         MobileAlignmentUtil.alignRightOf(_headerLevel,_headerRank,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerAlliance,_headerLevel,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerName,_headerAlliance,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerHistory,_headerName,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerBattlePoints,_headerHistory,_loc1_);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,_headerBattlePoints,_loc1_ + rightRoundHeaderFill.width);
      }
      
      protected function initHeaderWidths() : void
      {
         headerWidths["rank"] = 107;
         headerWidths["level"] = 84;
         headerWidths["alliance"] = 84;
         headerWidths["name"] = 235;
         headerWidths["history"] = 207;
         headerWidths["battle_points"] = 220;
      }
      
      protected function createHeaders() : void
      {
         initHeaderWidths();
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("ListHeaderSideBackground");
         _loc1_.width = 27;
         addChild(_loc1_);
         headers = new Vector.<MobileListHeaderView>();
         var _temp_3:* = §§findproperty(MobileListHeaderView);
         var _temp_2:* = true;
         var _loc2_:String = "ui.windows.league.list.headers.rank";
         _headerRank = new MobileListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc2_),headerWidths["rank"],LeagueMembersListColumnType.RANK);
         addChild(_headerRank);
         headers.push(_headerRank);
         var _temp_6:* = §§findproperty(MobileListHeaderView);
         var _temp_5:* = true;
         var _loc3_:String = "ui.windows.league.list.headers.level";
         _headerLevel = new MobileListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc3_),headerWidths["level"],LeagueMembersListColumnType.LEVEL);
         addChild(_headerLevel);
         headers.push(_headerLevel);
         _headerAlliance = new MobileListHeaderView(true,"",headerWidths["alliance"],LeagueMembersListColumnType.ALLIANCE,0,"IconAllianceM",0.6);
         addChild(_headerAlliance);
         headers.push(_headerAlliance);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = true;
         var _loc4_:String = "ui.windows.league.list.headers.name";
         _headerName = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc4_),headerWidths["name"],LeagueMembersListColumnType.NAME);
         addChild(_headerName);
         headers.push(_headerName);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = false;
         var _loc5_:String = "ui.windows.league.list.headers.history";
         _headerHistory = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc5_),headerWidths["history"],LeagueMembersListColumnType.UNSORTABLE);
         addChild(_headerHistory);
         headers.push(_headerHistory);
         var _temp_16:* = §§findproperty(MobileListHeaderView);
         var _temp_15:* = true;
         var _loc6_:String = "m.ui.windows.league.list.headers.points";
         _headerBattlePoints = new MobileListHeaderView(_temp_15,peak.i18n.PText.INSTANCE.getText0(_loc6_),headerWidths["battle_points"],LeagueMembersListColumnType.BATTLE_POINTS);
         addChild(_headerBattlePoints);
         headers.push(_headerBattlePoints);
         rightRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         _loc1_.width = 27;
         rightRoundHeaderFill.scaleX = -1;
         addChild(rightRoundHeaderFill);
      }
      
      protected function initSort() : void
      {
         _members.sort(LeagueMembersListColumnType.RANK.ascComperator);
      }
      
      public function initHeaders(param1:MobileListHeaderView) : void
      {
         for each(var _loc2_ in headers)
         {
            _loc2_.updateSortingDirection(0);
         }
         _sortedHeader = param1;
         initSort();
         alignHeaders();
      }
      
      public function updateWithMembers(param1:Vector.<LeagueMemberInfo>, param2:Profile) : void
      {
         _members = param1;
         _me = param2;
         initHeaders(_headerBattlePoints);
         update();
      }
      
      public function updateAccordingToSorting() : void
      {
         _members.sort(_sortedHeader.getComperatorFunction());
         update();
      }
      
      private function update() : void
      {
         _memberList.dataProvider = new ListCollection(_members);
         _memberList.validate();
      }
      
      public function headerClicked(param1:MobileListHeaderView) : void
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
      
      public function get headerRank() : MobileListHeaderView
      {
         return _headerRank;
      }
      
      public function get headerLevel() : MobileListHeaderView
      {
         return _headerLevel;
      }
      
      public function get headerAlliance() : MobileListHeaderView
      {
         return _headerAlliance;
      }
      
      public function get headerName() : MobileListHeaderView
      {
         return _headerName;
      }
      
      public function get headerBattlePoints() : MobileListHeaderView
      {
         return _headerBattlePoints;
      }
      
      public function get memberList() : MPList
      {
         return _memberList;
      }
   }
}

