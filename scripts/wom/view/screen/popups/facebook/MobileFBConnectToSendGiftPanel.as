package wom.view.screen.popups.facebook
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFBConnectToSendGiftPanel extends Sprite implements View
   {
      
      private static const WINDOW_WIDTH:int = 798;
      
      private static const WINDOW_HEIGHT:int = 415;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _clementineAsset:DisplayObject;
      
      private var _goldFortune:DisplayObject;
      
      private var _goldFortune2:DisplayObject;
      
      private var _getCaption:MPTextField;
      
      private var _goldAmountCaption:MPTextField;
      
      private var _goldIcon:DisplayObject;
      
      private var _infoMessageTF:MPTextField;
      
      private var _speechBubble:MobileSpeechBubbleView;
      
      private var _connectButton:MobileWomButton;
      
      public function MobileFBConnectToSendGiftPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("MobileDarkBackground");
         _background.height = 415;
         _background.width = 798;
         addChild(_background);
         _goldFortune = assetRepository.getDisplayObject("FBGoldStack");
         addChild(_goldFortune);
         _goldFortune2 = assetRepository.getDisplayObject("FBGoldStack");
         addChild(_goldFortune2);
         _clementineAsset = assetRepository.getDisplayObject("MPose4");
         _clementineAsset.scaleX = -1;
         addChild(_clementineAsset);
         var _temp_6:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_5:* = 313;
         var _loc1_:String = "m.ui.popups.facebookGetGold.loginText";
         _speechBubble = new MobileSpeechBubbleView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc1_),getCaptionTextFormat(30,"center",16777215),false,26,92,21);
         addChild(_speechBubble);
         _speechBubble.speechBubbleArrow.visible = false;
         _getCaption = new MobileCaptionTextField();
         _getCaption.textRendererProperties.textFormat = getCaptionTextFormat(46,"left",16777215);
         addChild(_getCaption);
         var _temp_9:* = _getCaption;
         var _loc2_:String = "m.ui.popups.facebookGetGold.get";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _goldIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_goldIcon);
         _goldAmountCaption = new MobileCaptionTextField();
         _goldAmountCaption.textRendererProperties.textFormat = getCaptionTextFormat(46,"left",16777215);
         addChild(_goldAmountCaption);
         var _temp_12:* = _goldAmountCaption;
         var _loc3_:String = "m.ui.popups.facebookGetGold.goldAmount";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _infoMessageTF = new MobileWomTextField();
         _infoMessageTF.textRendererProperties.textFormat = getWomTextFormat(23,"center",16777215);
         _infoMessageTF.width = 523;
         _infoMessageTF.textRendererProperties.wordWrap = true;
         addChild(_infoMessageTF);
         var _temp_14:* = _infoMessageTF;
         var _loc4_:String = "m.ui.popups.facebookGetGold.sendGiftText";
         _temp_14.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _connectButton = MobileWomUIComponentFactory.createMobileColoredButton("DarkBlue","Large");
         _connectButton.width = 373;
         addChild(_connectButton);
         var _temp_16:* = _connectButton;
         var _loc5_:String = "m.ui.popups.facebookGetGold.connectNow";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _speechBubble.textField.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_infoMessageTF,_background,42);
         MobileAlignmentUtil.alignAccordingToPositionOf(_goldFortune,_background,120,119);
         MobileAlignmentUtil.alignAccordingToPositionOf(_goldFortune2,_goldFortune,150);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_speechBubble,_background,110);
         MobileAlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,_clementineAsset.width - 37,161);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_speechBubble.textField,_speechBubble.speechBubbleBg,_speechBubble.textFieldMarginTop);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_goldIcon,_speechBubble,65);
         MobileAlignmentUtil.alignAccordingToPositionOf(_getCaption,_speechBubble,56,75);
         MobileAlignmentUtil.alignRightOf(_goldAmountCaption,_getCaption,53);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_connectButton,_background,291);
      }
      
      public function get connectButton() : MobileWomButton
      {
         return _connectButton;
      }
   }
}

