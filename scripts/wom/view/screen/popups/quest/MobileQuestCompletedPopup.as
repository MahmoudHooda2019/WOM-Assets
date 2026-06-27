package wom.view.screen.popups.quest
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.dto.RewardDTO;
   import wom.model.game.quest.QuestInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.quest.MobileRewardGroupView;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileQuestCompletedPopup extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 615;
      
      private static const WINDOW_HEIGHT:int = 478;
      
      private var _questInfo:QuestInfo;
      
      private var _name:String;
      
      private var questDetailsBackground:DisplayObject;
      
      private var lightAnimationView:MobileLightAnimationView;
      
      private var questTitleTextField:MPTextField;
      
      private var completionFlavourTextField:MPTextField;
      
      private var _sharePromptTextField:MPTextField;
      
      private var _rewardView:MobileRewardGroupView;
      
      private var _boostAndShareButton:MobileWomButton;
      
      public function MobileQuestCompletedPopup(param1:QuestInfo, param2:String)
      {
         _questInfo = param1;
         _name = param2;
         super(615,478);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc5_:String = "ui.popups.questcompleted.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         var _temp_2:* = §§findproperty(MobileRewardGroupView);
         var _loc6_:String = "ui.popups.questcompleted.rewards";
         _rewardView = new MobileRewardGroupView(peak.i18n.PText.INSTANCE.getText0(_loc6_),getCaptionTextFormat(33),1,465,116);
         addChild(_rewardView);
         var _loc1_:Vector.<RewardDTO> = new Vector.<RewardDTO>();
         for each(var _loc2_ in _questInfo.rewards)
         {
            _loc1_.push(_loc2_);
         }
         _rewardView.updateWithRewards(_loc1_);
         questTitleTextField = new MobileCaptionTextField();
         questTitleTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(questTitleTextField);
         var _temp_5:* = questTitleTextField;
         var _loc7_:String = "quest." + _questInfo.questId + ".title";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         completionFlavourTextField = new MobileWomTextField();
         completionFlavourTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center");
         completionFlavourTextField.textRendererProperties.wordWrap = true;
         completionFlavourTextField.width = 470;
         addChild(completionFlavourTextField);
         var _temp_7:* = completionFlavourTextField;
         var _loc8_:String = "quest." + _questInfo.questId + ".brag";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _sharePromptTextField = new MobileCaptionTextField();
         _sharePromptTextField.textRendererProperties.textFormat = getCaptionTextFormat(25,"center");
         _sharePromptTextField.textRendererProperties.wordWrap = true;
         _sharePromptTextField.width = 380;
         addChild(_sharePromptTextField);
         var _temp_10:* = _sharePromptTextField;
         var _temp_9:* = "ui.popups.questcompleted.shareprompt";
         var _loc9_:String = _name;
         var _loc10_:String = _temp_9;
         _temp_10.text = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
         _boostAndShareButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _boostAndShareButton.width = 318;
         var _temp_12:* = _boostAndShareButton;
         var _loc11_:String = "ui.popups.questcompleted.boastandshare";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(_boostAndShareButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         lightAnimationView = new MobileLightAnimationView();
         lightAnimationView.scaleX = lightAnimationView.scaleY = 2.5;
         addChild(lightAnimationView);
         questDetailsBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         questDetailsBackground.width = 532;
         questDetailsBackground.height = 280;
         addChild(questDetailsBackground);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(questDetailsBackground,_background,77);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(questTitleTextField,questDetailsBackground,-13);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(completionFlavourTextField,questDetailsBackground,35);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rewardView,questDetailsBackground,125);
         MobileAlignmentUtil.alignAccordingToPositionOf(lightAnimationView,questDetailsBackground,questDetailsBackground.width >> 1,questDetailsBackground.height >> 1);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_boostAndShareButton,_background,478 - 52);
         MobileAlignmentUtil.alignAboveWithXMarginOf(_sharePromptTextField,_boostAndShareButton,_boostAndShareButton.width - _sharePromptTextField.width >> 1);
      }
      
      public function updateSharePromptTextField(param1:String) : void
      {
         _name = param1;
         var _temp_3:* = _sharePromptTextField;
         var _temp_2:* = "ui.popups.questcompleted.shareprompt";
         var _loc2_:String = _name;
         var _loc3_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         drawLayout();
      }
      
      public function get boostAndShareButton() : MobileWomButton
      {
         return _boostAndShareButton;
      }
      
      public function get questInfo() : QuestInfo
      {
         return _questInfo;
      }
   }
}

