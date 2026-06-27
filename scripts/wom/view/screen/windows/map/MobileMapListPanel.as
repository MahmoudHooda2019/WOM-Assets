package wom.view.screen.windows.map
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.Profile;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileMapListPanel extends Sprite
   {
      
      public static const WIDTH:int = 999;
      
      private static const LIST_HEIGHT:int = 548;
      
      public static const FIRST_MARGIN:int = 5;
      
      private static const ROWS_PER_PAGE:int = 7;
      
      public static const LEVEL_WIDTH:int = 84;
      
      public static const ALLIANCE_WIDTH:int = 79;
      
      public static const NAME_WIDTH:int = 248;
      
      public static const BP_WIDTH:int = 120;
      
      public static const HISTORY_WIDTH:int = 120;
      
      public static const DIPLOMACY_WIDTH:int = 146;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _allMapPlayers:Vector.<MapMemberInfo>;
      
      private var _attackableMapPlayers:Vector.<MapMemberInfo>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      private var _levelHeader:MobileListHeaderView;
      
      private var _allianceHeader:MobileListHeaderView;
      
      private var _nameHeader:MobileListHeaderView;
      
      private var _bpHeader:MobileListHeaderView;
      
      private var _historyHeader:MobileListHeaderView;
      
      private var _diplomacyHeader:MobileListHeaderView;
      
      private var _headers:Vector.<MobileListHeaderView>;
      
      private var _showAllSelected:Boolean = false;
      
      private var _memberList:MPList;
      
      public function MobileMapListPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _memberList = new MPList();
         _memberList.itemRendererFactory = memberRendererFactory;
         _memberList.x = 0;
         _memberList.y = 65;
         _memberList.height = 548;
         _memberList.width = 999;
         addChild(_memberList);
         createHeaders();
         _sortedHeader = null;
         drawLayout();
      }
      
      private function memberRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileMapListMemberRenderer = new MobileMapListMemberRenderer(assetRepository);
         _loc1_.width = 999;
         _loc1_.height = 96;
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _levelHeader.x = 5;
         MobileAlignmentUtil.alignRightOf(_allianceHeader,_levelHeader,_loc1_);
         MobileAlignmentUtil.alignRightOf(_nameHeader,_allianceHeader,_loc1_);
         MobileAlignmentUtil.alignRightOf(_bpHeader,_nameHeader,_loc1_);
         MobileAlignmentUtil.alignRightOf(_historyHeader,_bpHeader,_loc1_);
         MobileAlignmentUtil.alignRightOf(_diplomacyHeader,_historyHeader,_loc1_);
      }
      
      private function createHeaders() : void
      {
         _headers = new Vector.<MobileListHeaderView>();
         var _temp_3:* = §§findproperty(MobileListHeaderView);
         var _temp_2:* = true;
         var _loc1_:String = "ui.windows.map.level";
         _levelHeader = new MobileListHeaderView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),84,MobileMapListColumnType.LEVEL);
         addChild(_levelHeader);
         _headers.push(_levelHeader);
         _allianceHeader = new MobileListHeaderView(true,"",79,MobileMapListColumnType.ALLIANCE,0,"IconAllianceM",0.6);
         addChild(_allianceHeader);
         _headers.push(_allianceHeader);
         var _temp_7:* = §§findproperty(MobileListHeaderView);
         var _temp_6:* = true;
         var _loc2_:String = "ui.windows.map.bp";
         _bpHeader = new MobileListHeaderView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),120,MobileMapListColumnType.BATTLE_POINTS);
         addChild(_bpHeader);
         _headers.push(_bpHeader);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = true;
         var _loc3_:String = "ui.windows.map.name";
         _nameHeader = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc3_),248,MobileMapListColumnType.NAME);
         addChild(_nameHeader);
         _headers.push(_nameHeader);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = true;
         var _loc4_:String = "ui.windows.map.history";
         _historyHeader = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc4_),120,MobileMapListColumnType.BATTLES);
         addChild(_historyHeader);
         _headers.push(_historyHeader);
         var _temp_16:* = §§findproperty(MobileListHeaderView);
         var _temp_15:* = true;
         var _loc5_:String = "ui.windows.map.diplomacy";
         _diplomacyHeader = new MobileListHeaderView(_temp_15,peak.i18n.PText.INSTANCE.getText0(_loc5_),146,MobileMapListColumnType.DIPLOMACY);
         addChild(_diplomacyHeader);
         _headers.push(_diplomacyHeader);
      }
      
      public function clearList() : void
      {
      }
      
      public function updateListAccordingToCheckBoxSelection(param1:Boolean = false) : void
      {
         if(_showAllSelected)
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
      
      public function headerClicked(param1:MobileListHeaderView) : void
      {
         updateHeaderStatus(param1);
         updateAccordingToSortingAndCheckBox();
      }
      
      private function updateHeaderStatus(param1:MobileListHeaderView) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MobileListHeaderView = null;
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
         var _loc2_:Vector.<MapMemberInfo> = _showAllSelected ? _allMapPlayers : _attackableMapPlayers;
         if(_loc2_)
         {
            if(_sortedHeader)
            {
               _loc2_.sort(param1 ? MobileMapListColumnType.LEVEL_AND_TYPE.ascComperator : _sortedHeader.getComperatorFunction());
            }
            else
            {
               _loc2_.sort(MobileMapListColumnType.LEVEL_AND_TYPE.ascComperator);
            }
         }
         _memberList.dataProvider = new ListCollection(_loc2_);
         _memberList.validate();
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
      
      public function get bpHeader() : MobileListHeaderView
      {
         return _bpHeader;
      }
      
      public function get levelHeader() : MobileListHeaderView
      {
         return _levelHeader;
      }
      
      public function get allianceHeader() : MobileListHeaderView
      {
         return _allianceHeader;
      }
      
      public function set allMapPlayers(param1:Vector.<MapMemberInfo>) : void
      {
         _allMapPlayers = param1;
      }
      
      public function updateWithMembers(param1:Dictionary, param2:TutorialListInfo) : void
      {
         var _loc4_:Profile = null;
         var _loc3_:Boolean = TutorialListInfo.checkInNpcRevengeTutorial(param2);
         _attackableMapPlayers = new Vector.<MapMemberInfo>();
         _allMapPlayers = new Vector.<MapMemberInfo>();
         for each(var _loc5_ in param1)
         {
            if(_loc5_.isAttackable())
            {
               if(_loc3_)
               {
                  _loc4_ = TutorialListInfo.getProfileAccordingToTutorial(_loc5_.profile,param2);
                  if(!_loc4_.isNpc)
                  {
                     _attackableMapPlayers.push(_loc5_);
                  }
                  else if(_loc4_.npcId == "NPC_D")
                  {
                     _loc5_.profileAccordingToTutorial = _loc4_;
                     _attackableMapPlayers.splice(0,0,_loc5_);
                  }
               }
               else if(_loc5_.isEventNpc || !_loc5_.profile.isNpc)
               {
                  _attackableMapPlayers.push(_loc5_);
               }
            }
            if(_loc5_.isEventNpc || !_loc5_.profile.isNpc)
            {
               _allMapPlayers.push(_loc5_);
            }
         }
         _memberList.dataProvider = new ListCollection(_attackableMapPlayers);
         _memberList.validate();
      }
      
      public function get memberList() : MPList
      {
         return _memberList;
      }
      
      public function set showAllSelected(param1:Boolean) : void
      {
         _showAllSelected = param1;
      }
   }
}

