package wom.view.screen.popups.league
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLeagueSeasonEndedSuccessPopUp extends MobileLeagueSeasonEndedPopUp
   {
      
      private var leagueWinAsset:DisplayObject;
      
      private var rewardBackground:DisplayObject;
      
      private var rewardAsset:DisplayObject;
      
      private var rewardLabel:MPTextField;
      
      private var rewardTF:MPTextField;
      
      private var _reward:int;
      
      private var _rpReward:Boolean;
      
      public function MobileLeagueSeasonEndedSuccessPopUp(param1:Number, param2:int, param3:Number, param4:int, param5:Boolean)
      {
         super(param1,param2,param3);
         _reward = param4;
         _rpReward = param5;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _workerAsset.visible = false;
         rewardLabel = new MobileCaptionTextField();
         rewardLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(rewardLabel);
         var _temp_2:* = rewardLabel;
         var _loc1_:String = "ui.windows.league.reward.title";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         rewardAsset = assetRepository.getDisplayObject(_rpReward ? "IconBPS" : "IconGoldS");
         addChild(rewardAsset);
         rewardTF = new MobileCaptionTextField();
         rewardTF.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(rewardTF);
         rewardTF.text = String(_reward);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         leagueWinAsset = assetRepository.getDisplayObject("LeagueWin");
         addChild(leagueWinAsset);
         MobileAlignmentUtil.alignAccordingToPositionOf(leagueWinAsset,_background,152,53);
         rewardBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         rewardBackground.width = 170;
         rewardBackground.height = 61;
         addChild(rewardBackground);
      }
      
      override protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.ended.success.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override protected function getBackgroundAssetId() : String
      {
         return "LeagueBackground";
      }
      
      override protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.ended.success.mdone";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(rewardLabel)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(rewardBackground,_background,_background.height - rewardBackground.height - 60);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,rewardBackground,-descTextField.height);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(titleTextField,_background,46);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rewardLabel,rewardBackground,16);
            MobileAlignmentUtil.alignRightWithYMarginOf(rewardAsset,rewardLabel,-7,10);
            MobileAlignmentUtil.alignRightWithYMarginOf(rewardTF,rewardAsset,7,-14);
         }
      }
   }
}

