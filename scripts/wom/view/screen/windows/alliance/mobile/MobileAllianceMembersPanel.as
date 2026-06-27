package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.game.alliance.AllianceMemberListColumnType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileAllianceMembersPanel extends Sprite
   {
      
      public static const WIDTH:int = 1000;
      
      public static const HEIGHT:int = 574;
      
      public static const HEADER_WIDTH_KEY_LEVEL:String = "level";
      
      public static const HEADER_WIDTH_KEY_NAME:String = "name";
      
      public static const HEADER_WIDTH_KEY_BATTLE_POINTS:String = "battle_points";
      
      public static const HEADER_WIDTH_KEY_ACTIONS:String = "actions";
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var headerWidths:Dictionary;
      
      protected var headers:Vector.<MobileListHeaderView>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      protected var _headerLevel:MobileListHeaderView;
      
      protected var _headerName:MobileListHeaderView;
      
      protected var _headerBattlePoints:MobileListHeaderView;
      
      protected var headerActions:MobileListHeaderView;
      
      protected var leftRoundHeaderFill:DisplayObject;
      
      protected var rightRoundHeaderFill:DisplayObject;
      
      private var _membersList:MPList;
      
      private var _members:Vector.<AllianceMemberInfo>;
      
      private var _widthDifference:int;
      
      private var _fromBrowseTab:Boolean;
      
      private var _allianceToBeViewed:AllianceDetailInfo;
      
      private var _ownGameId:String;
      
      public function MobileAllianceMembersPanel(param1:int, param2:Boolean = false)
      {
         super();
         headerWidths = new Dictionary();
         _members = new Vector.<AllianceMemberInfo>();
         _widthDifference = param1;
         _fromBrowseTab = param2;
      }
      
      public static function get visibleWidth() : int
      {
         return 1000;
      }
      
      public static function get visibleHeight() : int
      {
         return 574;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         createHeaders();
         initSort();
         _membersList = new MPList();
         _membersList.itemRendererFactory = allianceMembersRendererFactory;
         _membersList.width = 969;
         addChild(_membersList);
         _membersList.height = 574 - 40;
         _membersList.verticalScrollPolicy = "on";
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         alignHeaders();
         MobileAlignmentUtil.alignAccordingToPositionOf(_membersList,this,(_widthDifference >> 1) + 15,65);
      }
      
      protected function alignHeaders() : void
      {
         var _loc1_:int = 0;
         leftRoundHeaderFill.x = 0;
         leftRoundHeaderFill.y = -5;
         MobileAlignmentUtil.alignRightOf(_headerLevel,leftRoundHeaderFill,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerName,_headerLevel,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerBattlePoints,_headerName,_loc1_);
         MobileAlignmentUtil.alignRightOf(headerActions,_headerBattlePoints,_loc1_);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,headerActions,_loc1_ + rightRoundHeaderFill.width);
      }
      
      protected function initHeaderWidths() : void
      {
         headerWidths["level"] = 90;
         headerWidths["name"] = 222;
         headerWidths["battle_points"] = 179;
         headerWidths["actions"] = 474;
      }
      
      protected function allianceMembersRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileAllianceMemberViewRenderer = new MobileAllianceMemberViewRenderer(assetRepository,headerWidths,_ownGameId,_fromBrowseTab);
         _loc1_.width = 969;
         _loc1_.height = 94 + 10;
         return _loc1_;
      }
      
      public function updateWithOwnGameId(param1:String) : void
      {
         _ownGameId = param1;
      }
      
      public function updateWithMembers(param1:Vector.<AllianceMemberInfo>) : void
      {
         _members = param1;
         if(param1 == null)
         {
            if(_membersList && _membersList.dataProvider)
            {
               _membersList.dataProvider.removeAll();
            }
         }
         else
         {
            _membersList.dataProvider = new ListCollection(param1);
            _membersList.validate();
         }
      }
      
      protected function createHeaders() : void
      {
         initHeaderWidths();
         headers = new Vector.<MobileListHeaderView>();
         leftRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         leftRoundHeaderFill.width = 17 + (_widthDifference >> 1);
         addChild(leftRoundHeaderFill);
         var _temp_4:* = §§findproperty(MobileListHeaderView);
         var _temp_3:* = true;
         var _loc1_:String = "ui.windows.alliance.members.filter.level";
         _headerLevel = new MobileListHeaderView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc1_),headerWidths["level"],AllianceMemberListColumnType.LEVEL);
         addChild(_headerLevel);
         headers.push(_headerLevel);
         var _temp_7:* = §§findproperty(MobileListHeaderView);
         var _temp_6:* = true;
         var _loc2_:String = "ui.windows.alliance.members.filter.name";
         _headerName = new MobileListHeaderView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),headerWidths["name"],AllianceMemberListColumnType.NAME);
         addChild(_headerName);
         headers.push(_headerName);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = true;
         var _loc3_:String = "m.ui.windows.alliance.members.filter.battlepoints";
         _headerBattlePoints = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc3_),headerWidths["battle_points"],AllianceMemberListColumnType.BATTLE_POINTS,0,null,1,getCaptionTextFormat(17,"center"));
         addChild(_headerBattlePoints);
         headers.push(_headerBattlePoints);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = false;
         var _loc4_:String = "ui.windows.alliance.members.filter.actions";
         headerActions = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc4_),headerWidths["actions"],AllianceMemberListColumnType.UNSORTABLE);
         addChild(headerActions);
         headers.push(headerActions);
         rightRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         rightRoundHeaderFill.width = 17 + (_widthDifference >> 1);
         rightRoundHeaderFill.scaleX = -1;
         addChild(rightRoundHeaderFill);
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
      
      public function updateAccordingToSorting() : void
      {
         _members.sort(_sortedHeader.getComperatorFunction());
         updateWithMembers(_members);
      }
      
      protected function initSort() : void
      {
         _members.sort(AllianceMemberListColumnType.BATTLE_POINTS_LEADER_FIRST.dscComperator);
      }
      
      public function get membersList() : MPList
      {
         return _membersList;
      }
      
      public function get members() : Vector.<AllianceMemberInfo>
      {
         return _members;
      }
      
      public function get headerLevel() : MobileListHeaderView
      {
         return _headerLevel;
      }
      
      public function get headerName() : MobileListHeaderView
      {
         return _headerName;
      }
      
      public function get headerBattlePoints() : MobileListHeaderView
      {
         return _headerBattlePoints;
      }
      
      public function get fromBrowseTab() : Boolean
      {
         return _fromBrowseTab;
      }
      
      public function get allianceToBeViewed() : AllianceDetailInfo
      {
         return _allianceToBeViewed;
      }
      
      public function set allianceToBeViewed(param1:AllianceDetailInfo) : void
      {
         _allianceToBeViewed = param1;
         if(_allianceToBeViewed == null)
         {
            updateWithMembers(null);
         }
      }
   }
}

