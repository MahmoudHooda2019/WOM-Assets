package wom.view.screen.windows.rank
{
   import fl.controls.RadioButton;
   import fl.controls.RadioButtonGroup;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.game.rank.RankingInfo;
   import wom.model.game.rank.RankingRow;
   import wom.model.game.rank.RankingSortCriteria;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomRadioButton;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.RankingPageButton;
   import wom.view.component.button.WomButton;
   import wom.view.util.LineUtil;
   import wom.view.util.PagingPanel;
   
   public class BaseRankingPanel extends PagingPanel
   {
      
      protected static const WIDTH:int = 603;
      
      protected static const HEIGHT:int = 417;
      
      public static const MAX_PAGE:int = 10;
      
      protected var _rankingInfo:RankingInfo;
      
      protected var _rowViews:Vector.<BaseRankingRowView>;
      
      protected var _intervalRadioGroup:RadioButtonGroup;
      
      protected var _allTimeRadio:RadioButton;
      
      protected var _weeklyRadio:RadioButton;
      
      protected var _dailyRadio:RadioButton;
      
      protected var _headerRankTextField:TextField;
      
      protected var _headerPlayerTextField:TextField;
      
      protected var _headerOptionTextField:TextField;
      
      protected var _headerTotalPointsTextField:TextField;
      
      protected var _pageButtons:Vector.<WomButton>;
      
      protected var _youButton:WomButton;
      
      protected var _currentPageHasUser:Boolean;
      
      protected var _criterion:RankingSortCriteria;
      
      public function BaseRankingPanel()
      {
         super(603,417);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _rowViews = new Vector.<BaseRankingRowView>();
         _intervalRadioGroup = new RadioButtonGroup("interval");
         var _loc1_:TextFormat = Languages.activeLanguageId == "nl" ? WomTextFormats.WOM_16 : WomTextFormats.WOM_20;
         _allTimeRadio = new WomRadioButton();
         _allTimeRadio.selected = true;
         _allTimeRadio.group = _intervalRadioGroup;
         _allTimeRadio.setStyle("textFormat",_loc1_);
         var _temp_4:* = _allTimeRadio;
         var _loc3_:String = "ui.windows.rank.alltime";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_allTimeRadio);
         _weeklyRadio = new WomRadioButton();
         _weeklyRadio.group = _intervalRadioGroup;
         _weeklyRadio.setStyle("textFormat",_loc1_);
         var _temp_6:* = _weeklyRadio;
         var _loc4_:String = "ui.windows.rank.weekly";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_weeklyRadio);
         _dailyRadio = new WomRadioButton();
         _dailyRadio.group = _intervalRadioGroup;
         _dailyRadio.setStyle("textFormat",_loc1_);
         var _temp_8:* = _dailyRadio;
         var _loc5_:String = "ui.windows.rank.daily";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_dailyRadio);
         var _loc2_:Sprite = new Sprite();
         addChild(_loc2_);
         LineUtil.drawHorizontalSeparatorLine(_loc2_,1,601,null,null,27);
         _headerRankTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerRankTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerRankTextField.autoSize = "left";
         addChild(_headerRankTextField);
         var _temp_10:* = _headerRankTextField;
         var _loc6_:String = "ui.windows.rank.playerscores.header.rank";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _headerPlayerTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerPlayerTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerPlayerTextField.autoSize = "left";
         addChild(_headerPlayerTextField);
         var _temp_12:* = _headerPlayerTextField;
         var _loc7_:String = "ui.windows.rank.playerscores.header.player";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _headerOptionTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerOptionTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _headerOptionTextField.autoSize = "left";
         addChild(_headerOptionTextField);
         var _temp_14:* = _headerOptionTextField;
         var _loc8_:String = "ui.windows.rank.option";
         _temp_14.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _headerTotalPointsTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _headerTotalPointsTextField.defaultTextFormat = WomTextFormats.RIGHT_16;
         _headerTotalPointsTextField.autoSize = "left";
         addChild(_headerTotalPointsTextField);
         var _temp_16:* = _headerTotalPointsTextField;
         var _loc9_:String = "ui.windows.rank.playerscores.header.totalpoints";
         _temp_16.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _youButton = new RankingPageButton();
         _youButton.width = 63;
         var _temp_18:* = _youButton;
         var _loc10_:String = "ui.windows.rank.playerscores.you";
         _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_youButton);
         _pageButtons = new Vector.<WomButton>();
         _previousButton.visible = false;
         _nextButton.visible = false;
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc2_:int = 0;
         super.drawLayout();
         var _loc1_:int = _allTimeRadio.width + _dailyRadio.width + _weeklyRadio.width + 70;
         AlignmentUtil.alignAccordingToPositionOf(_allTimeRadio,bg,bg.width - _loc1_ >> 1,4);
         AlignmentUtil.alignRightOf(_weeklyRadio,_allTimeRadio,35);
         AlignmentUtil.alignRightOf(_dailyRadio,_weeklyRadio,35);
         AlignmentUtil.alignAccordingToPositionOf(_headerRankTextField,bg,53 - (_headerRankTextField.width >> 1),36);
         AlignmentUtil.alignAccordingToPositionOf(_headerPlayerTextField,bg,106,36);
         AlignmentUtil.alignAccordingToPositionOf(_headerTotalPointsTextField,bg,417 - (_headerTotalPointsTextField.width >> 1),36);
         AlignmentUtil.alignAccordingToPositionOf(_headerOptionTextField,bg,534 - (_headerOptionTextField.width >> 1),36);
         _loc2_ = 0;
         while(_loc2_ < _rowViews.length)
         {
            _rowViews[_loc2_].x = 0;
            _rowViews[_loc2_].y = _loc2_ * 71 + 61;
            _loc2_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(_youButton,bg,540,420);
         _loc2_ = 0;
         while(_loc2_ < _pageButtons.length)
         {
            AlignmentUtil.alignAccordingToPositionOf(_pageButtons[_loc2_],_youButton,-((_pageButtons.length - _loc2_) * 34),0);
            _loc2_++;
         }
      }
      
      public function rankingInfoUpdated(param1:RankingInfo, param2:String) : void
      {
         var _loc8_:int = 0;
         var _loc7_:RankingRow = null;
         var _loc5_:BaseRankingRowView = null;
         var _loc6_:WomButton = null;
         _currentPageNumber = param1.page;
         _currentPageHasUser = false;
         _rankingInfo = param1;
         clearAll();
         var _loc4_:Boolean = _rankingInfo.sortCriteria == RankingSortCriteria.BP || _rankingInfo.sortCriteria == RankingSortCriteria.DAILY_BP || _rankingInfo.sortCriteria == RankingSortCriteria.WEEKLY_BP;
         var _loc3_:int = _rankingInfo.firstRankInPage;
         _loc8_ = 0;
         while(_loc8_ < _rankingInfo.rankings.length)
         {
            _loc7_ = _rankingInfo.rankings[_loc8_];
            if(_loc7_.profile.gameId == param2)
            {
               _currentPageHasUser = true;
            }
            _loc5_ = new BaseRankingRowView(_loc7_,_loc3_++,_loc7_.profile.gameId == param2,_loc4_);
            addChild(_loc5_);
            _rowViews.push(_loc5_);
            _loc8_++;
         }
         _loc8_ = 1;
         while(_loc8_ <= 10 && _loc8_ <= _rankingInfo.totalPageCount)
         {
            _loc6_ = new RankingPageButton();
            _loc6_.width = 32;
            _loc6_.label = _loc8_.toFixed(0);
            addChild(_loc6_);
            _pageButtons.push(_loc6_);
            _loc8_++;
         }
         setPagingButtonsVisibility(_rankingInfo.page);
         drawLayout();
      }
      
      private function clearAll() : void
      {
         for each(var _loc1_ in _rowViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _rowViews.length = 0;
         for each(var _loc2_ in _pageButtons)
         {
            if(contains(_loc2_))
            {
               removeChild(_loc2_);
            }
         }
         _pageButtons.length = 0;
      }
      
      override public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber != 1 && _currentPageNumber <= 10;
         _nextButton.visible = _currentPageNumber < 10;
      }
      
      public function get pageButtons() : Vector.<WomButton>
      {
         return _pageButtons;
      }
      
      public function get youButton() : WomButton
      {
         return _youButton;
      }
      
      public function get rankingInfo() : RankingInfo
      {
         return _rankingInfo;
      }
      
      public function get currentPageHasUser() : Boolean
      {
         return _currentPageHasUser;
      }
      
      public function get criterion() : RankingSortCriteria
      {
         return _criterion;
      }
      
      public function get intervalRadioGroup() : RadioButtonGroup
      {
         return _intervalRadioGroup;
      }
      
      public function updateCriterion() : void
      {
      }
   }
}

