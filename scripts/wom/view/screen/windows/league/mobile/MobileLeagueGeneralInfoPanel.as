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
   
   public class MobileLeagueGeneralInfoPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var bg:DisplayObject;
      
      private var _titleTextField:MPTextField;
      
      private var _leagueInfoViews:Vector.<MobileLeagueInfoSmallView>;
      
      private var _desc1TextField:MPTextField;
      
      private var _desc2Bg:DisplayObject;
      
      private var _desc2TextField:MPTextField;
      
      private var _rewardPanel:MobileLeagueBonusAndRewardPanel;
      
      public function MobileLeagueGeneralInfoPanel()
      {
         super();
         _leagueInfoViews = new Vector.<MobileLeagueInfoSmallView>();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         bg = assetRepository.getDisplayObject("MobileDarkBackground");
         bg.width = 999;
         bg.height = 548;
         addChild(bg);
         _titleTextField = new MobileWomTextField();
         _titleTextField.textRendererProperties.textFormat = getCaptionTextFormat(50);
         addChild(_titleTextField);
         var _temp_3:* = _titleTextField;
         var _loc1_:String = "ui.windows.league.info.title";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _desc1TextField = new MobileWomTextField();
         _desc1TextField.textRendererProperties.textFormat = getWomTextFormat(23,"left",16777215);
         _desc1TextField.textRendererProperties.wordWrap = true;
         _desc1TextField.width = 865;
         addChild(_desc1TextField);
         var _temp_5:* = _desc1TextField;
         var _loc2_:String = "m.ui.windows.league.info.p1";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _desc2Bg = assetRepository.getDisplayObject("MobileBeigeBackground");
         _desc2Bg.width = 680;
         _desc2Bg.height = 71;
         addChild(_desc2Bg);
         _desc2TextField = new MobileWomTextField();
         _desc2TextField.textRendererProperties.textFormat = getWomTextFormat(23);
         addChild(_desc2TextField);
         var _temp_8:* = _desc2TextField;
         var _loc3_:String = "m.ui.windows.league.info.p2";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _rewardPanel = new MobileLeagueBonusAndRewardPanel(assetRepository,null,false,null,false);
         addChild(_rewardPanel);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(_titleTextField,bg,40,15);
         _loc1_ = 0;
         while(_loc1_ < _leagueInfoViews.length && _loc1_ < 6)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_leagueInfoViews[_loc1_],bg,153 * _loc1_ + 60,210 - 30 * _loc1_);
            _loc1_++;
         }
         _desc1TextField.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_desc1TextField,bg,389);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_desc2Bg,bg,448);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_desc2TextField,_desc2Bg,_desc2Bg.width - _desc2TextField.width - _rewardPanel.width - 15 >> 1);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rewardPanel,_desc2TextField,_desc2TextField.width + 15);
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
         var _loc2_:MobileLeagueInfoSmallView = null;
         var _loc3_:int = 0;
         clearLeagueInfoViews();
         if(param1 != null && param1.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = new MobileLeagueInfoSmallView(param1[_loc3_],null,null,_loc3_ == 0);
               _leagueInfoViews.push(_loc2_);
               addChild(_loc2_);
               _loc3_++;
            }
            drawLayout();
         }
      }
      
      public function updateBonusAndRewardPanel(param1:Vector.<LeagueBonusAndRewardDTO>) : void
      {
         if(contains(_rewardPanel))
         {
            removeChild(_rewardPanel);
         }
         _rewardPanel = new MobileLeagueBonusAndRewardPanel(assetRepository,param1,false,null,false);
         addChild(_rewardPanel);
         _rewardPanel.drawLayout();
         toggleRewardPanel(true);
         drawLayout();
      }
      
      public function toggleRewardPanel(param1:Boolean) : void
      {
         _desc2TextField.visible = _rewardPanel.visible = param1;
      }
   }
}

