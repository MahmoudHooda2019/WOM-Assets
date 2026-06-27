package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.view.component.AutoSizingCaptionTextField;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.BaseWindowPanel;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class LeagueHeaderPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 75;
      
      private var _levelDIO:LeagueLevelDIO = null;
      
      private var _leagueInfoView:LeagueInfoSmallView;
      
      private var _leagueLevelNameTextField:TextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var _minBPTextField:TextField;
      
      private var _seasonEndsTextField:TextField;
      
      private var _bonusAndRewardPanel:LeagueBonusAndRewardPanel;
      
      private var _leagueLevelZeroDescTextField:TextField;
      
      public function LeagueHeaderPanel()
      {
         super(603,75);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         graphics.lineStyle(0,12495979,1);
         graphics.moveTo(2,74);
         graphics.lineTo(603 - 2,74);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         if(_levelDIO != null)
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_leagueInfoView,bg,8);
            if(_levelDIO.league >= 4)
            {
               _leagueInfoView.y += 5;
            }
            if(_levelDIO.id == 0)
            {
               AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_leagueLevelZeroDescTextField,_leagueInfoView,_leagueInfoView.width + 12);
            }
            else
            {
               AlignmentUtil.alignAccordingToPositionOf(_leagueLevelNameTextField,bg,80,8);
               AlignmentUtil.alignBelowOf(_battlePointsIcon,_leagueLevelNameTextField,-1);
               AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minBPTextField,_battlePointsIcon,_battlePointsIcon.width + 3);
               AlignmentUtil.alignBelowOf(_seasonEndsTextField,_battlePointsIcon,-1);
               AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_bonusAndRewardPanel,bg,bg.width - _bonusAndRewardPanel.width - 11);
            }
         }
         super.drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      private function clear() : void
      {
         if(_leagueInfoView && contains(_leagueInfoView))
         {
            removeChild(_leagueInfoView);
         }
         if(_leagueLevelNameTextField && contains(_leagueLevelNameTextField))
         {
            removeChild(_leagueLevelNameTextField);
         }
         if(_battlePointsIcon && contains(_battlePointsIcon))
         {
            removeChild(_battlePointsIcon);
         }
         if(_minBPTextField && contains(_minBPTextField))
         {
            removeChild(_minBPTextField);
         }
         if(_seasonEndsTextField && contains(_seasonEndsTextField))
         {
            removeChild(_seasonEndsTextField);
         }
         if(_bonusAndRewardPanel && contains(_bonusAndRewardPanel))
         {
            removeChild(_bonusAndRewardPanel);
         }
         if(_leagueLevelZeroDescTextField && contains(_leagueLevelZeroDescTextField))
         {
            removeChild(_leagueLevelZeroDescTextField);
         }
      }
      
      public function update(param1:LeagueLevelDIO, param2:Number, param3:Boolean, param4:Number) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(param1 != null)
         {
            clear();
            _levelDIO = param1;
            _leagueInfoView = new LeagueInfoSmallView(_levelDIO,true,true);
            addChild(_leagueInfoView);
            if(_levelDIO.id == 0)
            {
               _leagueLevelZeroDescTextField = new WomTextField();
               _leagueLevelZeroDescTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
               _leagueLevelZeroDescTextField.multiline = true;
               _leagueLevelZeroDescTextField.wordWrap = true;
               _leagueLevelZeroDescTextField.autoSize = "left";
               _leagueLevelZeroDescTextField.width = 475;
               addChild(_leagueLevelZeroDescTextField);
               var _temp_4:* = _leagueLevelZeroDescTextField;
               var _loc7_:String = "ui.windows.league.level0";
               _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            else
            {
               _leagueLevelNameTextField = new AutoSizingCaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
               _leagueLevelNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
               _leagueLevelNameTextField.autoSize = "left";
               _leagueLevelNameTextField.width = 190;
               addChild(_leagueLevelNameTextField);
               var _temp_6:* = _leagueLevelNameTextField;
               var _loc8_:String = "domain.league.levels." + _levelDIO.id + ".name";
               _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               _battlePointsIcon = assetRepository.getDisplayObject("CrownIcon");
               addChild(_battlePointsIcon);
               _minBPTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
               _minBPTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
               _minBPTextField.autoSize = "left";
               _minBPTextField.text = _levelDIO.minBPToJoin + "" + (_levelDIO.id != 16 ? "-" + _levelDIO.maxBPToJoin : "+");
               addChild(_minBPTextField);
               _seasonEndsTextField = new WomTextField();
               _seasonEndsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
               _seasonEndsTextField.autoSize = "left";
               var _temp_11:* = _seasonEndsTextField;
               var _temp_10:* = "ui.windows.league.seasonendsin";
               var _loc9_:String = LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param2);
               var _loc10_:String = _temp_10;
               _temp_11.text = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
               addChild(_seasonEndsTextField);
               _loc5_ = new Vector.<LeagueBonusAndRewardDTO>();
               var _temp_17:* = _loc5_;
               var _temp_16:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_15:* = "Iron";
               var _temp_14:* = null;
               var _temp_13:* = "ui.windows.league.bonus.percentage";
               var _loc11_:int = _levelDIO.ironProductionBonusPercentage;
               var _loc12_:String = _temp_13;
               _temp_17.push(new LeagueBonusAndRewardDTO(_temp_15,_temp_14,peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_)));
               _loc6_ = new Vector.<LeagueBonusAndRewardDTO>();
               var _temp_21:* = _loc6_;
               var _temp_20:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_19:* = param3 ? "Rp" : "Gold27";
               var _loc13_:String = "ui.common.position.1";
               _temp_21.push(new LeagueBonusAndRewardDTO(_temp_19,peak.i18n.PText.INSTANCE.getText0(_loc13_),String(int(_levelDIO.rewards[0] * param4))));
               var _temp_24:* = _loc6_;
               var _temp_23:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_22:* = param3 ? "Rp" : "Gold27";
               var _loc14_:String = "ui.common.position.2";
               _temp_24.push(new LeagueBonusAndRewardDTO(_temp_22,peak.i18n.PText.INSTANCE.getText0(_loc14_),String(int(_levelDIO.rewards[1] * param4))));
               var _temp_27:* = _loc6_;
               var _temp_26:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_25:* = param3 ? "Rp" : "Gold27";
               var _loc15_:String = "ui.common.position.3";
               _temp_27.push(new LeagueBonusAndRewardDTO(_temp_25,peak.i18n.PText.INSTANCE.getText0(_loc15_),String(int(_levelDIO.rewards[2] * param4))));
               _bonusAndRewardPanel = new LeagueBonusAndRewardPanel(_loc5_,true,_loc6_,true);
               addChild(_bonusAndRewardPanel);
            }
            drawLayout();
         }
      }
      
      public function updateRemainingSeasonDuration(param1:Number) : void
      {
         if(_seasonEndsTextField)
         {
            var _temp_2:* = _seasonEndsTextField;
            var _temp_1:* = "ui.windows.league.seasonendsin";
            var _loc2_:String = LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1);
            var _loc3_:String = _temp_1;
            _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         }
      }
      
      public function get battlePointsIcon() : DisplayObject
      {
         return _battlePointsIcon;
      }
   }
}

