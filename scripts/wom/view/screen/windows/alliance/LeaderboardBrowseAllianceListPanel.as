package wom.view.screen.windows.alliance
{
   import fl.controls.RadioButton;
   import fl.controls.RadioButtonGroup;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceSortDirection;
   import wom.model.game.alliance.AllianceSortType;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomRadioButton;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.RankingPageButton;
   import wom.view.component.button.WomButton;
   import wom.view.util.LineUtil;
   
   public class LeaderboardBrowseAllianceListPanel extends BrowseAllianceListPanel
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 417;
      
      private static const VIEWS_PER_PAGE:int = 5;
      
      private static const MAX_PAGE_BUTTONS_COUNT:int = 10;
      
      private var _intervalRadioGroup:RadioButtonGroup;
      
      protected var _allTimeRadio:RadioButton;
      
      protected var _weeklyRadio:RadioButton;
      
      protected var _dailyRadio:RadioButton;
      
      protected var _tournamentRadio:RadioButton;
      
      protected var _headerRankTextField:TextField;
      
      protected var _headerPlayerTextField:TextField;
      
      protected var _headerMembersTextField:TextField;
      
      protected var _headerScoreTextField:TextField;
      
      private var _pageButtons:Vector.<WomButton>;
      
      private var _youButton:WomButton;
      
      private var _warningTextField:TextField;
      
      public function LeaderboardBrowseAllianceListPanel()
      {
         super(603,417);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _warningTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _warningTextField.defaultTextFormat = WomTextFormats.CENTER_36;
         _warningTextField.width = 603;
         _warningTextField.autoSize = "center";
         _warningTextField.multiline = true;
         _warningTextField.wordWrap = true;
         _warningTextField.visible = false;
         addChild(_warningTextField);
      }
      
      override protected function createAllianceWindowSpecificFields() : void
      {
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_warningTextField)
         {
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_warningTextField,bg,160);
         }
      }
      
      override protected function drawHeaderRelatedLayout() : void
      {
         var _loc1_:int = _allTimeRadio.width + _dailyRadio.width + _weeklyRadio.width + _tournamentRadio.width + 70;
         AlignmentUtil.alignAccordingToPositionOf(_tournamentRadio,bg,bg.width - _loc1_ >> 1,4);
         AlignmentUtil.alignRightOf(_allTimeRadio,_tournamentRadio,30);
         AlignmentUtil.alignRightOf(_weeklyRadio,_allTimeRadio,30);
         AlignmentUtil.alignRightOf(_dailyRadio,_weeklyRadio,30);
         AlignmentUtil.alignAccordingToPositionOf(_headerRankTextField,bg,15,36);
         AlignmentUtil.alignAccordingToPositionOf(_headerPlayerTextField,bg,125,36);
         AlignmentUtil.alignAccordingToPositionOf(_headerMembersTextField,bg,340,36);
         AlignmentUtil.alignAccordingToPositionOf(_headerScoreTextField,bg,395,36);
      }
      
      override protected function drawAllianceViewsLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _allianceViews.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_allianceViews[_loc1_],bg,0,_loc1_ * 71 + 61);
            _loc1_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(_youButton,bg,540,420);
         _loc1_ = 0;
         while(_loc1_ < _pageButtons.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_pageButtons[_loc1_],_youButton,-((_pageButtons.length - _loc1_) * 34),0);
            _loc1_++;
         }
      }
      
      override protected function createHeaders() : void
      {
         _intervalRadioGroup = new RadioButtonGroup("interval");
         var _loc2_:String = "ui.windows.rank.alltime";
         _allTimeRadio = createRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _loc3_:String = "ui.windows.rank.weekly";
         _weeklyRadio = createRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = "ui.windows.rank.daily";
         _dailyRadio = createRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         var _loc5_:String = "ui.windows.rank.tournament";
         _tournamentRadio = createRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc5_),120);
         _tournamentRadio.selected = true;
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         LineUtil.drawHorizontalSeparatorLine(_loc1_,1,601,null,null,27);
         _headerRankTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerRankTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerRankTextField.autoSize = "left";
         addChild(_headerRankTextField);
         var _temp_11:* = _headerRankTextField;
         var _loc6_:String = "ui.windows.rank.alliance.header.rank";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _headerPlayerTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerPlayerTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerPlayerTextField.autoSize = "left";
         addChild(_headerPlayerTextField);
         var _temp_13:* = _headerPlayerTextField;
         var _loc7_:String = "ui.windows.rank.alliance.header.name";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _headerMembersTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerMembersTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerMembersTextField.autoSize = "left";
         addChild(_headerMembersTextField);
         var _temp_15:* = _headerMembersTextField;
         var _loc8_:String = "ui.windows.rank.alliance.header.member";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _headerScoreTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerScoreTextField.defaultTextFormat = WomTextFormats.RIGHT_16;
         _headerScoreTextField.width = 145;
         _headerScoreTextField.height = 20;
         addChild(_headerScoreTextField);
         var _temp_17:* = _headerScoreTextField;
         var _loc9_:String = "ui.windows.rank.alliance.header.points";
         _temp_17.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _youButton = new RankingPageButton();
         _youButton.width = 63;
         var _temp_19:* = _youButton;
         var _loc10_:String = "ui.windows.rank.alliance.you";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_youButton);
         _pageButtons = new Vector.<WomButton>();
      }
      
      protected function createRadioButton(param1:String, param2:int = 90) : WomRadioButton
      {
         var _loc3_:WomRadioButton = new WomRadioButton();
         _loc3_.group = _intervalRadioGroup;
         _loc3_.setStyle("textFormat",Languages.activeLanguageId == "nl" ? WomTextFormats.WOM_16 : WomTextFormats.WOM_20);
         _loc3_.label = param1;
         _loc3_.width = param2;
         addChild(_loc3_);
         return _loc3_;
      }
      
      override protected function updateSortingDirections() : void
      {
      }
      
      override public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber != 0 && _currentPageNumber <= 10;
         _nextButton.visible = _currentPageNumber < 10 - 1 && !_lastPage;
      }
      
      override public function update(param1:AllianceSortType, param2:AllianceSortDirection, param3:Vector.<AllianceDetailInfo>, param4:AllianceSummaryInfo, param5:int, param6:Boolean, param7:Boolean = true, param8:int = 0) : void
      {
         var _loc12_:int = 0;
         var _loc9_:BrowseAllianceView = null;
         var _loc11_:WomButton = null;
         _alliances = param3;
         _currentPageNumber = param5;
         _lastPage = param6;
         clearAll();
         _loc12_ = 0;
         while(_loc12_ < _alliances.length && _loc12_ < 5)
         {
            _loc9_ = new BrowseAllianceView(_alliances[_loc12_],param4,_loc12_ + 1,true);
            addChild(_loc9_);
            _allianceViews.push(_loc9_);
            _loc12_++;
         }
         var _loc10_:int = param8 > 10 ? 10 : param8;
         _loc12_ = 1;
         while(_loc12_ <= _loc10_)
         {
            _loc11_ = new RankingPageButton();
            _loc11_.width = 32;
            _loc11_.label = _loc12_.toFixed(0);
            addChild(_loc11_);
            _pageButtons.push(_loc11_);
            _loc12_++;
         }
         drawLayout();
      }
      
      override protected function clearAll() : void
      {
         super.clearAll();
         for each(var _loc1_ in _pageButtons)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
      }
      
      public function updateYouButtonSelection(param1:AllianceSummaryInfo) : void
      {
         var _loc2_:int = 0;
         _youButton.enabled = param1 != null;
         _youButton.selected = false;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < _alliances.length)
            {
               if(_alliances[_loc2_].id == param1.id)
               {
                  _youButton.selected = true;
               }
               _loc2_++;
            }
         }
      }
      
      override public function get sortType() : AllianceSortType
      {
         var _loc1_:AllianceSortType = AllianceSortType.BP;
         if(_weeklyRadio.selected)
         {
            return AllianceSortType.WEEKLY_BP;
         }
         if(_dailyRadio.selected)
         {
            return AllianceSortType.DAILY_BP;
         }
         if(_tournamentRadio.selected)
         {
            return AllianceSortType.TOURNAMENT;
         }
         return _loc1_;
      }
      
      public function updateDurationRelatedFields(param1:Number, param2:Number, param3:Number) : void
      {
         if(param2 > 0)
         {
            var _temp_1:* = true;
            var _loc4_:String = "ui.windows.alliance.tournament.warning.starting";
            setWarningText(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         }
         else if(param1 > 0)
         {
            var _temp_4:* = param3 == 0 && _alliances.length == 0;
            var _loc5_:String = "ui.windows.alliance.tournament.warning.shouldwin";
            setWarningText(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc5_));
         }
         else
         {
            var _temp_6:* = true;
            var _loc6_:String = "ui.windows.alliance.tournament.tournamentlimbo";
            setWarningText(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc6_));
         }
         drawLayout();
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
      
      public function get youButton() : WomButton
      {
         return _youButton;
      }
      
      public function get pageButtons() : Vector.<WomButton>
      {
         return _pageButtons;
      }
      
      public function get intervalRadioGroup() : RadioButtonGroup
      {
         return _intervalRadioGroup;
      }
      
      public function isTournamentSelected() : Boolean
      {
         return _tournamentRadio.selected;
      }
   }
}

