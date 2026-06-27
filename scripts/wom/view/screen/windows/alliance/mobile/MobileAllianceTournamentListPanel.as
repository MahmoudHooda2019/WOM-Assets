package wom.view.screen.windows.alliance.mobile
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceListColumnType;
   import wom.model.game.alliance.AllianceRankingInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileAllianceTournamentListPanel extends Sprite implements View
   {
      
      public static const HEADER_WIDTH_RANK:int = 140;
      
      public static const HEADER_WIDTH_NAME:int = 250;
      
      public static const HEADER_WIDTH_MEMBERS:int = 140;
      
      public static const HEADER_WIDTH_REWARD:int = 151;
      
      public static const HEADER_WIDTH_SCORE:int = 263;
      
      private static const HEADER_FILLER_WIDTH:int = 27;
      
      private var _widthDifference:int;
      
      private var _isRanking:Boolean;
      
      private var _alliances:Vector.<AllianceDetailInfo>;
      
      private var _allianceList:MPList;
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _headers:Vector.<MobileListHeaderView>;
      
      private var _sortedHeader:MobileListHeaderView;
      
      private var _headerRank:MobileListHeaderView;
      
      private var _headerName:MobileListHeaderView;
      
      private var _headerMembers:MobileListHeaderView;
      
      private var _headerReward:MobileListHeaderView;
      
      private var _headerScore:MobileListHeaderView;
      
      private var leftRoundHeaderFill:DisplayObject;
      
      private var rightRoundHeaderFill:DisplayObject;
      
      private var _tournamentBackground:DisplayObject;
      
      private var _helpButton:MPButton;
      
      private var nextAttackLabel:MPTextField;
      
      private var nextAttackTimeLabel:MPTextField;
      
      private var tournamentLabel:MPTextField;
      
      private var tournamentTimeLabel:MPTextField;
      
      private var _tournamentAttackButton:MPButton;
      
      private var _attackWithGoldButton:MobileWomButton;
      
      private var tournamentContainer:Sprite;
      
      public function MobileAllianceTournamentListPanel(param1:int, param2:Boolean = false)
      {
         super();
         _widthDifference = param1;
         _myAllianceSummary = null;
         _alliances = new Vector.<AllianceDetailInfo>();
         _isRanking = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         tournamentContainer = new Sprite();
         addChild(tournamentContainer);
         _tournamentBackground = assetRepository.getDisplayObject("MobileInnerBeigeBackground");
         _tournamentBackground.width = 999 + _widthDifference;
         _tournamentBackground.height = 85;
         tournamentContainer.addChild(_tournamentBackground);
         _helpButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         tournamentContainer.addChild(_helpButton);
         nextAttackLabel = new MobileCaptionTextField();
         nextAttackLabel.textRendererProperties.textFormat = getCaptionTextFormat(27);
         var _temp_5:* = nextAttackLabel;
         var _loc3_:String = "ui.windows.alliance.tournament.nextattack";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         tournamentContainer.addChild(nextAttackLabel);
         nextAttackTimeLabel = new MobileCaptionTextField();
         nextAttackTimeLabel.textRendererProperties.textFormat = getCaptionTextFormat(27);
         nextAttackTimeLabel.text = "33:44";
         tournamentContainer.addChild(nextAttackTimeLabel);
         tournamentLabel = new MobileCaptionTextField();
         tournamentLabel.textRendererProperties.textFormat = getCaptionTextFormat(27);
         var _temp_8:* = tournamentLabel;
         var _loc4_:String = "ui.windows.alliance.tournament.tournamentend";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         tournamentContainer.addChild(tournamentLabel);
         tournamentTimeLabel = new MobileCaptionTextField();
         tournamentTimeLabel.textRendererProperties.textFormat = getCaptionTextFormat(27);
         tournamentTimeLabel.text = "33:44:22";
         tournamentContainer.addChild(tournamentTimeLabel);
         _tournamentAttackButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _tournamentAttackButton.width = 320;
         var _temp_11:* = _tournamentAttackButton;
         var _loc5_:String = "ui.windows.alliance.tournament.attack";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         tournamentContainer.addChild(_tournamentAttackButton);
         _attackWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         var _temp_13:* = _attackWithGoldButton;
         var _loc6_:String = "ui.windows.alliance.tournament.attacknow";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _attackWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _attackWithGoldButton.width = 320;
         tournamentContainer.addChild(_attackWithGoldButton);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("MobileDarkBackground");
         _loc1_.width = 999 + _widthDifference;
         _loc1_.height = 576;
         _loc1_.y = 96;
         tournamentContainer.addChild(_loc1_);
         var _loc2_:int = 947;
         _allianceList = new MPList();
         _allianceList.itemRendererFactory = allianceTournamentRendererFactory;
         _allianceList.x = 27 + (_widthDifference >> 1) - 1;
         _allianceList.y = _isRanking ? 110 : 164;
         _allianceList.height = _isRanking ? 545 : 500;
         _allianceList.width = _loc2_;
         addChild(_allianceList);
         createHeaders();
      }
      
      private function allianceTournamentRendererFactory() : MPItemRenderer
      {
         var _loc1_:MobileAllianceTournamentViewRenderer = new MobileAllianceTournamentViewRenderer(assetRepository,_myAllianceSummary);
         _loc1_.width = _allianceList.width;
         _loc1_.height = 104;
         return _loc1_;
      }
      
      protected function createHeaders() : void
      {
         _headers = new Vector.<MobileListHeaderView>();
         leftRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         leftRoundHeaderFill.width = 27 + (_widthDifference >> 1);
         addChild(leftRoundHeaderFill);
         var _temp_4:* = §§findproperty(MobileListHeaderView);
         var _temp_3:* = false;
         var _loc1_:String = "ui.windows.alliance.tournament.filter.rank";
         _headerRank = new MobileListHeaderView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc1_),140,AllianceListColumnType.UNSORTABLE);
         addChild(_headerRank);
         _headers.push(_headerRank);
         var _temp_7:* = §§findproperty(MobileListHeaderView);
         var _temp_6:* = false;
         var _loc2_:String = "ui.windows.alliance.tournament.filter.name";
         _headerName = new MobileListHeaderView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),250,AllianceListColumnType.UNSORTABLE);
         addChild(_headerName);
         _headers.push(_headerName);
         var _temp_10:* = §§findproperty(MobileListHeaderView);
         var _temp_9:* = false;
         var _loc3_:String = "ui.windows.alliance.tournament.filter.members";
         _headerMembers = new MobileListHeaderView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc3_),140,AllianceListColumnType.UNSORTABLE);
         addChild(_headerMembers);
         _headers.push(_headerMembers);
         var _temp_13:* = §§findproperty(MobileListHeaderView);
         var _temp_12:* = false;
         var _loc4_:String = "ui.windows.alliance.tournament.filter.reward";
         _headerReward = new MobileListHeaderView(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc4_),151,AllianceListColumnType.UNSORTABLE);
         addChild(_headerReward);
         _headers.push(_headerReward);
         var _temp_16:* = §§findproperty(MobileListHeaderView);
         var _temp_15:* = false;
         var _loc5_:String = "ui.windows.alliance.tournament.filter.score";
         _headerScore = new MobileListHeaderView(_temp_15,peak.i18n.PText.INSTANCE.getText0(_loc5_),263,AllianceListColumnType.UNSORTABLE);
         addChild(_headerScore);
         _headers.push(_headerScore);
         rightRoundHeaderFill = assetRepository.getDisplayObject("ListHeaderSideBackground");
         rightRoundHeaderFill.width = 27 + (_widthDifference >> 1);
         rightRoundHeaderFill.scaleX = -1;
         addChild(rightRoundHeaderFill);
         _sortedHeader = _headerRank;
      }
      
      public function drawLayout() : void
      {
         drawHeaderRelatedLayout();
         drawTournamentRelatedLayout();
      }
      
      protected function drawHeaderRelatedLayout() : void
      {
         var _loc1_:int = 0;
         leftRoundHeaderFill.y = _isRanking ? 45 : 96;
         MobileAlignmentUtil.alignRightOf(_headerRank,leftRoundHeaderFill,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerName,_headerRank,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerMembers,_headerName,_loc1_);
         MobileAlignmentUtil.alignRightOf(_headerReward,_headerMembers,_loc1_);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_headerScore,_headerReward,_loc1_,151);
         MobileAlignmentUtil.alignRightOf(rightRoundHeaderFill,_headerScore,_loc1_ + rightRoundHeaderFill.width);
      }
      
      private function drawTournamentRelatedLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_tournamentAttackButton,_tournamentBackground,_tournamentBackground.width - _tournamentAttackButton.width - 10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_attackWithGoldButton,_tournamentBackground,_tournamentBackground.width - _attackWithGoldButton.width - 10);
         if(!_tournamentAttackButton.visible)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(nextAttackLabel,_attackWithGoldButton,-nextAttackLabel.width - 20,15);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(nextAttackTimeLabel,nextAttackLabel,25);
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_helpButton,_tournamentBackground,15);
         MobileAlignmentUtil.alignAccordingToPositionOf(tournamentLabel,_helpButton,_helpButton.width + 20,0);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(tournamentTimeLabel,tournamentLabel,25);
         tournamentContainer.visible = !_isRanking;
      }
      
      public function get alliances() : Vector.<AllianceDetailInfo>
      {
         return _alliances;
      }
      
      public function get allianceList() : MPList
      {
         return _allianceList;
      }
      
      public function update(param1:AllianceRankingInfo) : void
      {
         _alliances = param1.alliances;
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc2_ in _alliances)
         {
            _loc3_.push({
               "alliance":_loc2_,
               "myAllianceExists":_myAllianceSummary != null
            });
         }
         _allianceList.dataProvider = new ListCollection(_loc3_);
         _allianceList.validate();
         drawLayout();
      }
      
      public function get myAllianceSummary() : AllianceSummaryInfo
      {
         return _myAllianceSummary;
      }
      
      public function set myAllianceSummary(param1:AllianceSummaryInfo) : void
      {
         _myAllianceSummary = param1;
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
      }
      
      public function get helpButton() : MPButton
      {
         return _helpButton;
      }
      
      public function get tournamentAttackButton() : MPButton
      {
         return _tournamentAttackButton;
      }
      
      public function updateDurationRelatedFields(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Boolean = param1 <= 0;
         if(param3 > 0)
         {
            nextAttackLabel.visible = nextAttackTimeLabel.visible = _attackWithGoldButton.visible = _tournamentAttackButton.visible = false;
            tournamentTimeLabel.visible = tournamentLabel.visible = true;
            var _temp_3:* = tournamentLabel;
            var _loc6_:String = "ui.windows.alliance.tournament.tournamentstart";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            tournamentTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param3);
         }
         else if(param2 > 0)
         {
            nextAttackLabel.visible = nextAttackTimeLabel.visible = _attackWithGoldButton.visible = !_loc4_;
            _tournamentAttackButton.visible = _loc4_;
            tournamentTimeLabel.visible = tournamentLabel.visible = true;
            var _temp_6:* = tournamentLabel;
            var _loc7_:String = "ui.windows.alliance.tournament.tournamentend";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            tournamentTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param2);
            if(!_loc4_)
            {
               nextAttackTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param1);
               _attackWithGoldButton.rightLabel = StoreUtil.buildingPrice(0,param1 / 1000) + "";
            }
         }
         else
         {
            nextAttackLabel.visible = nextAttackTimeLabel.visible = _attackWithGoldButton.visible = _tournamentAttackButton.visible = tournamentTimeLabel.visible = false;
            tournamentLabel.visible = true;
            var _temp_10:* = tournamentLabel;
            var _loc8_:String = "ui.windows.alliance.tournament.tournamentlimbo";
            _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
         drawLayout();
      }
      
      public function get attackWithGoldButton() : MobileWomButton
      {
         return _attackWithGoldButton;
      }
   }
}

