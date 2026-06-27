package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileLeagueHeaderPanel extends Sprite
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 75;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _levelDIO:LeagueLevelDIO = null;
      
      private var background:DisplayObject;
      
      private var _leagueInfoView:MobileLeagueInfoSmallView;
      
      private var _leagueLevelNameTextField:MPTextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var _minBPTextField:MPTextField;
      
      private var _seasonEndsTextField:MPTextField;
      
      private var _bonusAndRewardPanel:MobileLeagueBonusAndRewardPanel;
      
      private var _leagueLevelZeroDescTextField:MPTextField;
      
      public function MobileLeagueHeaderPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileInnerBeigeBackground");
         background.width = 998;
         background.height = 111;
         addChild(background);
      }
      
      public function drawLayout() : void
      {
         if(_levelDIO != null)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_leagueInfoView,background,8);
            if(_levelDIO.league >= 4)
            {
               _leagueInfoView.y += 5;
            }
            if(_levelDIO.id == 0)
            {
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_leagueLevelZeroDescTextField,_leagueInfoView,_leagueInfoView.width + 12);
            }
            else
            {
               _leagueLevelNameTextField.validate();
               _minBPTextField.validate();
               MobileAlignmentUtil.alignAccordingToPositionOf(_leagueLevelNameTextField,background,124,15);
               MobileAlignmentUtil.alignBelowOf(_battlePointsIcon,_leagueLevelNameTextField,-2);
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minBPTextField,_battlePointsIcon,27);
               _minBPTextField.y += 3;
               MobileAlignmentUtil.alignBelowOf(_seasonEndsTextField,_battlePointsIcon,2);
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_bonusAndRewardPanel,background,background.width - _bonusAndRewardPanel.width - 52);
            }
         }
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
      
      public function update(param1:LeagueLevelDIO, param2:Number) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1 != null)
         {
            clear();
            _levelDIO = param1;
            _leagueInfoView = new MobileLeagueInfoSmallView(_levelDIO,true,true);
            addChild(_leagueInfoView);
            if(_levelDIO.id == 0)
            {
               _leagueLevelZeroDescTextField = new MobileWomTextField();
               _leagueLevelZeroDescTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
               _leagueLevelZeroDescTextField.textRendererProperties.wordWrap = true;
               _leagueLevelZeroDescTextField.width = 475;
               addChild(_leagueLevelZeroDescTextField);
               var _temp_4:* = _leagueLevelZeroDescTextField;
               var _loc5_:String = "ui.windows.league.level0";
               _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            }
            else
            {
               _leagueLevelNameTextField = new MobileWomTextField();
               _leagueLevelNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
               addChild(_leagueLevelNameTextField);
               var _temp_6:* = _leagueLevelNameTextField;
               var _loc6_:String = "domain.league.levels." + _levelDIO.id + ".name";
               _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               _battlePointsIcon = assetRepository.getDisplayObject("IconBPS");
               addChild(_battlePointsIcon);
               _minBPTextField = new MobileWomTextField();
               _minBPTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
               _minBPTextField.text = _levelDIO.minBPToJoin + "" + (_levelDIO.id != 16 ? "-" + _levelDIO.maxBPToJoin : "+");
               addChild(_minBPTextField);
               _seasonEndsTextField = new MobileWomTextField();
               _seasonEndsTextField.textRendererProperties.textFormat = getWomTextFormat(23);
               var _temp_11:* = _seasonEndsTextField;
               var _temp_10:* = "ui.windows.league.seasonendsin";
               var _loc7_:String = LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param2);
               var _loc8_:String = _temp_10;
               _temp_11.text = peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_);
               addChild(_seasonEndsTextField);
               _loc3_ = new Vector.<LeagueBonusAndRewardDTO>();
               var _temp_16:* = _loc3_;
               var _temp_15:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_14:* = "ResourceIconIron";
               var _temp_13:* = null;
               var _temp_12:* = "ui.windows.league.bonus.percentage";
               var _loc9_:int = _levelDIO.ironProductionBonusPercentage;
               var _loc10_:String = _temp_12;
               _temp_16.push(new LeagueBonusAndRewardDTO(_temp_14,_temp_13,peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_)));
               _loc4_ = new Vector.<LeagueBonusAndRewardDTO>();
               var _temp_20:* = _loc4_;
               var _temp_19:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_18:* = "IconRPM";
               var _loc11_:String = "ui.common.position.1";
               _temp_20.push(new LeagueBonusAndRewardDTO(_temp_18,peak.i18n.PText.INSTANCE.getText0(_loc11_),String(_levelDIO.rewards[0])));
               var _temp_23:* = _loc4_;
               var _temp_22:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_21:* = "IconRPM";
               var _loc12_:String = "ui.common.position.2";
               _temp_23.push(new LeagueBonusAndRewardDTO(_temp_21,peak.i18n.PText.INSTANCE.getText0(_loc12_),String(_levelDIO.rewards[1])));
               var _temp_26:* = _loc4_;
               var _temp_25:* = §§findproperty(LeagueBonusAndRewardDTO);
               var _temp_24:* = "IconRPM";
               var _loc13_:String = "ui.common.position.3";
               _temp_26.push(new LeagueBonusAndRewardDTO(_temp_24,peak.i18n.PText.INSTANCE.getText0(_loc13_),String(_levelDIO.rewards[2])));
               _bonusAndRewardPanel = new MobileLeagueBonusAndRewardPanel(assetRepository,_loc3_,true,_loc4_,true);
               addChild(_bonusAndRewardPanel);
               _bonusAndRewardPanel.drawLayout();
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

