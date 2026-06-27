package wom.view.screen.windows.map
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.component.attribute.data.MapTileData;
   import wom.view.component.WomCheckBox;
   import wom.view.ui.common.ListHeaderView;
   import wom.view.util.PagingPanel;
   
   public class MapListPanel extends PagingPanel
   {
      
      public static const WIDTH:int = 716;
      
      public static const HEIGHT:int = 514;
      
      public static const FIRST_MARGIN:int = 5;
      
      private static const ROWS_PER_PAGE:int = 7;
      
      public static const LEVEL_WIDTH:int = 74;
      
      public static const ALLIANCE_WIDTH:int = 82;
      
      public static const NAME_WIDTH:int = 113;
      
      public static const BP_WIDTH:int = 83;
      
      public static const HISTORY_WIDTH:int = 86;
      
      public static const DIPLOMACY_WIDTH:int = 106;
      
      private var _allMapPlayers:Vector.<MapTileData>;
      
      private var _attackableMapPlayers:Vector.<MapTileData>;
      
      private var _sortedHeader:ListHeaderView;
      
      private var _listMemberViews:Vector.<MapListMemberView>;
      
      private var _levelHeader:ListHeaderView;
      
      private var _allianceHeader:ListHeaderView;
      
      private var _nameHeader:ListHeaderView;
      
      private var _bpHeader:ListHeaderView;
      
      private var _historyHeader:ListHeaderView;
      
      private var _diplomacyHeader:ListHeaderView;
      
      private var _showAllCheckBox:WomCheckBox;
      
      private var _headers:Vector.<ListHeaderView>;
      
      private const headerHeight:int = 22;
      
      private var userLevel:int;
      
      public function MapListPanel(param1:int, param2:Vector.<MapTileData>)
      {
         super(716,514,7,1);
         this.userLevel = param1;
         _allMapPlayers = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         createHeaders();
         createAttackableMembersList();
         _listMemberViews = new Vector.<MapListMemberView>();
         _sortedHeader = null;
         _showAllCheckBox = new WomCheckBox();
         _showAllCheckBox.labelPlacement = "left";
         addChild(_showAllCheckBox);
         drawLayout();
      }
      
      private function createAttackableMembersList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MapTileData = null;
         _attackableMapPlayers = new Vector.<MapTileData>();
         _loc2_ = 0;
         while(_loc2_ < _allMapPlayers.length)
         {
            _loc1_ = _allMapPlayers[_loc2_];
            if(_loc1_.mapMemberInfo.isAttackable())
            {
               _attackableMapPlayers.push(_loc1_);
            }
            _loc2_++;
         }
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 1;
         _levelHeader.x = 5;
         _levelHeader.y = 10;
         AlignmentUtil.alignRightOf(_allianceHeader,_levelHeader,_loc1_);
         AlignmentUtil.alignRightOf(_nameHeader,_allianceHeader,_loc1_);
         AlignmentUtil.alignRightOf(_bpHeader,_nameHeader,_loc1_);
         AlignmentUtil.alignRightOf(_historyHeader,_bpHeader,_loc1_);
         AlignmentUtil.alignRightOf(_diplomacyHeader,_historyHeader,_loc1_);
         drawListLayout();
         _showAllCheckBox.x = 569;
         _showAllCheckBox.y = 7;
         _showAllCheckBox.width = 140;
         var _temp_1:* = _showAllCheckBox;
         var _loc2_:String = "ui.windows.map.showall";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         super.drawLayout();
      }
      
      private function drawListLayout() : void
      {
         var _loc1_:MapListMemberView = null;
         var _loc2_:int = 0;
         if(_listMemberViews.length >= 1)
         {
            AlignmentUtil.alignBelowWithXMarginOf(_listMemberViews[0],_levelHeader,-5,3);
            _loc1_ = _listMemberViews[0];
            _loc2_ = 1;
            while(_loc2_ < _listMemberViews.length)
            {
               AlignmentUtil.alignHeightSpecifiedBelowOf(_listMemberViews[_loc2_],_loc1_,0,69);
               _loc1_ = _listMemberViews[_loc2_];
               _loc2_++;
            }
         }
         setChildIndex(_nextButton,numChildren - 1);
         setChildIndex(_previousButton,numChildren - 2);
      }
      
      private function createHeaders() : void
      {
         _headers = new Vector.<ListHeaderView>();
         var _temp_3:* = §§findproperty(ListHeaderView);
         var _temp_2:* = true;
         var _loc1_:String = "ui.windows.map.level";
         _levelHeader = new ListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),74,22,MapListColumnType.LEVEL);
         addChild(_levelHeader);
         _headers.push(_levelHeader);
         var _temp_6:* = §§findproperty(ListHeaderView);
         var _temp_5:* = true;
         var _loc2_:String = "ui.windows.map.alliance";
         _allianceHeader = new ListHeaderView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc2_),82,22,MapListColumnType.ALLIANCE);
         addChild(_allianceHeader);
         _headers.push(_allianceHeader);
         var _temp_9:* = §§findproperty(ListHeaderView);
         var _temp_8:* = true;
         var _loc3_:String = "ui.windows.map.bp";
         _bpHeader = new ListHeaderView(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc3_),83,22,MapListColumnType.BATTLE_POINTS);
         addChild(_bpHeader);
         _headers.push(_bpHeader);
         var _temp_12:* = §§findproperty(ListHeaderView);
         var _temp_11:* = true;
         var _loc4_:String = "ui.windows.map.name";
         _nameHeader = new ListHeaderView(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc4_),113,22,MapListColumnType.NAME);
         addChild(_nameHeader);
         _headers.push(_nameHeader);
         var _temp_15:* = §§findproperty(ListHeaderView);
         var _temp_14:* = true;
         var _loc5_:String = "ui.windows.map.history";
         _historyHeader = new ListHeaderView(_temp_14,peak.i18n.PText.INSTANCE.getText0(_loc5_),86,22,MapListColumnType.BATTLES);
         addChild(_historyHeader);
         _headers.push(_historyHeader);
         var _temp_18:* = §§findproperty(ListHeaderView);
         var _temp_17:* = true;
         var _loc6_:String = "ui.windows.map.diplomacy";
         _diplomacyHeader = new ListHeaderView(_temp_17,peak.i18n.PText.INSTANCE.getText0(_loc6_),106,22,MapListColumnType.DIPLOMACY);
         addChild(_diplomacyHeader);
         _headers.push(_diplomacyHeader);
      }
      
      public function clearList() : void
      {
         var _loc1_:int = 0;
         if(_listMemberViews != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _listMemberViews.length)
            {
               if(contains(_listMemberViews[_loc1_]))
               {
                  removeChild(_listMemberViews[_loc1_]);
               }
               _loc1_++;
            }
         }
         _listMemberViews = new Vector.<MapListMemberView>();
      }
      
      public function updateListAccordingToCheckBoxSelection(param1:Boolean = false) : void
      {
         if(_showAllCheckBox.selected)
         {
            _sortedHeader = null;
         }
         else
         {
            _levelHeader.resetSortingDirection();
            _sortedHeader = _levelHeader;
         }
         updateHeaderStatus(_sortedHeader);
         updateAccordingToSortingAndCheckBox(param1);
      }
      
      public function showPage(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc3_:MapListMemberView = null;
         _currentPageNumber = param1;
         clearList();
         var _loc4_:Vector.<MapTileData> = _showAllCheckBox.selected ? _allMapPlayers : _attackableMapPlayers;
         var _loc5_:int = itemCountPerPage();
         var _loc2_:int = int(_loc4_.length);
         _loc6_ = param1 * _loc5_;
         while(_loc6_ < (param1 + 1) * _loc5_ && _loc6_ < _loc2_)
         {
            _loc3_ = new MapListMemberView(userLevel,_loc4_[_loc6_],(_loc6_ + 1) % _loc5_ == 0);
            addChild(_loc3_);
            _listMemberViews.push(_loc3_);
            _loc6_++;
         }
         setPagingButtonsVisibility(_loc4_.length);
         drawListLayout();
      }
      
      public function headerClicked(param1:ListHeaderView) : void
      {
         updateHeaderStatus(param1);
         updateAccordingToSortingAndCheckBox();
      }
      
      private function updateHeaderStatus(param1:ListHeaderView) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ListHeaderView = null;
         _loc3_ = 0;
         while(_loc3_ < _headers.length)
         {
            _loc2_ = _headers[_loc3_];
            _loc2_.sortingTypeUpdated(_loc2_ == param1);
            _loc3_++;
         }
         _sortedHeader = param1;
      }
      
      private function updateAccordingToSortingAndCheckBox(param1:Boolean = false) : void
      {
         var _loc2_:Vector.<MapTileData> = _showAllCheckBox.selected ? _allMapPlayers : _attackableMapPlayers;
         if(_sortedHeader)
         {
            _loc2_.sort(param1 ? MapListColumnType.LEVEL_AND_TYPE.ascComperator : _sortedHeader.getComperatorFunction());
         }
         else
         {
            _loc2_.sort(MapListColumnType.LEVEL_AND_TYPE.ascComperator);
         }
         showPage(0);
      }
      
      public function get showAllCheckBox() : WomCheckBox
      {
         return _showAllCheckBox;
      }
      
      public function get nameHeader() : DisplayObject
      {
         return _nameHeader;
      }
      
      public function get historyHeader() : DisplayObject
      {
         return _historyHeader;
      }
      
      public function get diplomacyHeader() : DisplayObject
      {
         return _diplomacyHeader;
      }
      
      public function get bpHeader() : ListHeaderView
      {
         return _bpHeader;
      }
      
      public function get levelHeader() : ListHeaderView
      {
         return _levelHeader;
      }
      
      public function get allianceHeader() : ListHeaderView
      {
         return _allianceHeader;
      }
      
      public function set allMapPlayers(param1:Vector.<MapTileData>) : void
      {
         _allMapPlayers = param1;
      }
   }
}

