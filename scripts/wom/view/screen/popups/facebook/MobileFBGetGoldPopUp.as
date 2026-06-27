package wom.view.screen.popups.facebook
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFBGetGoldPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 560;
      
      private static const WINDOW_HEIGHT:int = 352;
      
      private var _goldFortune:DisplayObject;
      
      private var _getCaption:MPTextField;
      
      private var _goldAmountCaption:MPTextField;
      
      private var _goldIcon:DisplayObject;
      
      private var _infoMessageBG:DisplayObject;
      
      private var _infoMessageTF:MPTextField;
      
      private var _mandatory:Boolean;
      
      private var _closeWithActionButton:Boolean;
      
      public function MobileFBGetGoldPopUp(param1:Boolean = false, param2:int = 560, param3:int = 352)
      {
         super(param2,param3);
         _mandatory = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _goldFortune = assetRepository.getDisplayObject("FBGoldStack");
         addChild(_goldFortune);
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         _imageAsset.scaleX = -1;
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 329;
         var _loc1_:String = "m.ui.popups.facebookGetGold.loginText";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc1_),getCaptionTextFormat(30,"center",16777215),false,26,92,21);
         addChild(_speechBubble);
         _getCaption = new MobileCaptionTextField();
         _getCaption.textRendererProperties.textFormat = getCaptionTextFormat(46,"left",16777215);
         var _temp_7:* = _getCaption;
         var _loc2_:String = "m.ui.popups.facebookGetGold.get";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_getCaption);
         _goldIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_goldIcon);
         _goldAmountCaption = new MobileCaptionTextField();
         _goldAmountCaption.textRendererProperties.textFormat = getCaptionTextFormat(46,"left",16777215);
         var _temp_10:* = _goldAmountCaption;
         var _loc3_:String = "m.ui.popups.facebookGetGold.goldAmount";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_goldAmountCaption);
         _infoMessageBG = assetRepository.getDisplayObject("MobileDarkBackground");
         _infoMessageBG.height = 52;
         _infoMessageBG.width = 487;
         addChild(_infoMessageBG);
         _infoMessageTF = new MobileWomTextField();
         _infoMessageTF.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
         var _temp_13:* = _infoMessageTF;
         var _loc4_:String = "m.ui.popups.facebookGetGold.permissionText";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_infoMessageTF);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("DarkBlue","Large");
         _actionButton.width = 497;
         var _temp_15:* = _actionButton;
         var _loc5_:String = "m.ui.popups.facebookGetGold.buttonText";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         var _temp_16:* = _actionButton;
         var _loc6_:String = "m.ui.popups.facebookGetGold.goldAmount";
         _temp_16.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _infoMessageTF.validate();
         _goldAmountCaption.validate();
         _getCaption.validate();
         _speechBubble.textField.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldFortune,_background,-65);
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,_imageAsset.width - 37,-37);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,194,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_speechBubble.textField,_speechBubble.speechBubbleBg,_speechBubble.textFieldMarginTop);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldIcon,_speechBubble,55);
         MobileAlignmentUtil.alignAccordingToPositionOf(_getCaption,_speechBubble,71,68);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_goldAmountCaption,_getCaption,118);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_infoMessageBG,_background,215);
         MobileAlignmentUtil.alignMiddleOf(_infoMessageTF,_infoMessageBG);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2 - 15);
      }
      
      public function get mandatory() : Boolean
      {
         return _mandatory;
      }
      
      public function get closeWithActionButton() : Boolean
      {
         return _closeWithActionButton;
      }
      
      public function set closeWithActionButton(param1:Boolean) : void
      {
         _closeWithActionButton = param1;
      }
   }
}

