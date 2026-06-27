package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.BaseWindowPanel;
   
   public class LeagueGeneralInfoPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 370;
      
      private var _titleTextField:TextField;
      
      private var _leagueInfoViews:Vector.<LeagueInfoSmallView>;
      
      private var _desc1TextField:TextField;
      
      private var _desc2TextField:TextField;
      
      private var _rewardPanel:LeagueBonusAndRewardPanel;
      
      private var _clementineAsset:DisplayObject;
      
      public function LeagueGeneralInfoPanel()
      {
         super(603,370);
         _leagueInfoViews = new Vector.<LeagueInfoSmallView>();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _titleTextField = new CaptionTextField(WomTextFormats.BROWN_FILTER);
         _titleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_32;
         _titleTextField.autoSize = "left";
         addChild(_titleTextField);
         var _temp_2:* = _titleTextField;
         var _loc1_:String = "ui.windows.league.info.title";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _desc1TextField = new WomTextField();
         _desc1TextField.defaultTextFormat = Languages.activeLanguageId == "ru" || Languages.activeLanguageId == "nl" ? WomTextFormats.FONT_SIZE_16 : WomTextFormats.FONT_SIZE_18;
         _desc1TextField.multiline = true;
         _desc1TextField.wordWrap = true;
         _desc1TextField.autoSize = "left";
         _desc1TextField.width = 360;
         addChild(_desc1TextField);
         var _temp_5:* = _desc1TextField;
         var _loc2_:String = "ui.windows.league.info.p1";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _desc2TextField = new WomTextField();
         _desc2TextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _desc2TextField.multiline = true;
         _desc2TextField.wordWrap = true;
         _desc2TextField.autoSize = "left";
         _desc2TextField.width = 270;
         addChild(_desc2TextField);
         var _temp_7:* = _desc2TextField;
         var _loc3_:String = "ui.windows.league.info.p2";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _rewardPanel = new LeagueBonusAndRewardPanel(null,false,null,false);
         addChild(_rewardPanel);
         _clementineAsset = assetRepository.getDisplayObject("PoseMedium9");
         addChild(_clementineAsset);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc1_:int = 0;
         AlignmentUtil.alignAccordingToPositionOf(_titleTextField,bg,40,15);
         _loc1_ = 0;
         while(_loc1_ < _leagueInfoViews.length && _loc1_ < 6)
         {
            AlignmentUtil.alignAccordingToPositionOf(_leagueInfoViews[_loc1_],bg,91 * _loc1_ + 36,113 - 19 * _loc1_);
            _loc1_++;
         }
         AlignmentUtil.alignAccordingToPositionOf(_desc2TextField,bg,30,370 - _desc2TextField.height - 25);
         AlignmentUtil.alignAboveOf(_desc1TextField,_desc2TextField,15);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rewardPanel,_desc2TextField,_desc2TextField.width);
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,bg,394,157);
         super.drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      private function clearLeagueInfoViews() : void
      {
         for each(var _loc1_ in _leagueInfoViews)
         {
            if(contains(_loc1_))
            {
               removeChild(_loc1_);
            }
         }
         _leagueInfoViews.length = 0;
      }
      
      public function updateLeagueLevels(param1:Vector.<LeagueLevelDIO>) : void
      {
         var _loc2_:LeagueInfoSmallView = null;
         var _loc3_:int = 0;
         clearLeagueInfoViews();
         if(param1 != null && param1.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = new LeagueInfoSmallView(param1[_loc3_],null,null,_loc3_ == 0);
               _leagueInfoViews.push(_loc2_);
               addChild(_loc2_);
               _loc3_++;
            }
            drawLayout();
         }
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _clementineAsset;
      }
      
      public function updateBonusAndRewardPanel(param1:Vector.<LeagueBonusAndRewardDTO>) : void
      {
         if(contains(_rewardPanel))
         {
            removeChild(_rewardPanel);
         }
         _rewardPanel = new LeagueBonusAndRewardPanel(param1,false,null,false);
         addChild(_rewardPanel);
         toggleRewardPanel(true);
         drawLayout();
      }
      
      public function toggleRewardPanel(param1:Boolean) : void
      {
         _desc2TextField.visible = _rewardPanel.visible = param1;
      }
   }
}

