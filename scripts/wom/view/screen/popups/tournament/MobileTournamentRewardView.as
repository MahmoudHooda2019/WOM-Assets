package wom.view.screen.popups.tournament
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceTournamentReward;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTournamentRewardView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _standing:int;
      
      private var _background:DisplayObject;
      
      private var rewardLabel:MPTextField;
      
      private var coinAsset:DisplayObject;
      
      private var coinTextField:MPTextField;
      
      private var _rewardAsset:DisplayObject;
      
      private var rewardTextField:MPTextField;
      
      public function MobileTournamentRewardView(param1:int)
      {
         super();
         _standing = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("MobileBeigeBackground");
         _background.width = visibleWidth;
         _background.height = visibleHeight;
         addChild(_background);
         rewardLabel = new MobileCaptionTextField();
         rewardLabel.textRendererProperties.textFormat = getCaptionTextFormat(25,"left");
         addChild(rewardLabel);
         var _temp_3:* = rewardLabel;
         var _loc1_:String = "ui.windows.tournament.ended.reward.label";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         coinAsset = assetRepository.getDisplayObject("IconGoldS");
         addChild(coinAsset);
         coinTextField = new MobileCaptionTextField();
         coinTextField.textRendererProperties.textFormat = getCaptionTextFormat(25,"left");
         addChild(coinTextField);
         coinTextField.text = AllianceTournamentReward.getAllianceTournamentReward(_standing) + "";
         if(_standing < 4)
         {
            _rewardAsset = assetRepository.getDisplayObject("TournamentRewardIcon" + _standing);
            _rewardAsset.scaleX = _rewardAsset.scaleX = 1.1;
            addChild(_rewardAsset);
            rewardTextField = new MobileCaptionTextField();
            rewardTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"left");
            addChild(rewardTextField);
            rewardTextField.text = "1";
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rewardLabel,_background,12);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(coinAsset,_background,110);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(coinTextField,_background,145);
         coinAsset.y -= 3;
         if(_standing < 4)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rewardAsset,_background,205);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rewardTextField,_background,230);
            _rewardAsset.y -= 3;
         }
      }
      
      private function get visibleWidth() : int
      {
         return _standing < 4 ? 248 : 210;
      }
      
      private function get visibleHeight() : int
      {
         return 60;
      }
      
      public function get rewardAsset() : DisplayObject
      {
         return _rewardAsset;
      }
   }
}

