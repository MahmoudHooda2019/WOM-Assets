package wom.view.screen.popups.gold
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class WeAreRichPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 450;
      
      private static const WINDOW_HEIGHT:int = 309;
      
      private var _imageBackground:DisplayObject;
      
      private var _clementineAsset:DisplayObject;
      
      private var _speechBubble:SpeechBubbleView;
      
      private var _goldFortuneAsset:DisplayObject;
      
      private var _paymentSuccessfulTextField:TextField;
      
      private var _awesomeButton:Button;
      
      public function WeAreRichPopUp()
      {
         super(450,309);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.wearerich.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageBackground = assetRepository.getDisplayObject("PopupBackgroundMini");
         addChildAt(_imageBackground,1);
         _clementineAsset = assetRepository.getDisplayObject("PoseMedium3");
         addChild(_clementineAsset);
         var _temp_5:* = §§findproperty(SpeechBubbleView);
         var _temp_4:* = 303;
         var _loc2_:String = "ui.windows.wearerich.speech.desc";
         _speechBubble = new SpeechBubbleView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),22,null,162,80);
         addChild(_speechBubble);
         _goldFortuneAsset = assetRepository.getDisplayObject("GoldFortune");
         addChild(_goldFortuneAsset);
         _paymentSuccessfulTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         _paymentSuccessfulTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         _paymentSuccessfulTextField.autoSize = "left";
         var _temp_9:* = _paymentSuccessfulTextField;
         var _loc3_:String = "ui.windows.wearerich.speech.header";
         _temp_9.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_paymentSuccessfulTextField);
         _awesomeButton = new WomBlueLargeButton();
         _awesomeButton.width = 162;
         var _temp_11:* = _awesomeButton;
         var _loc4_:String = "ui.windows.wearerich.awesome";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_awesomeButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,13,13);
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,-41,-52);
         AlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,107,66);
         AlignmentUtil.alignAccordingToPositionOf(_goldFortuneAsset,_background,192,40);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_paymentSuccessfulTextField,_goldFortuneAsset,75);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_awesomeButton,_background,309 - 33);
      }
      
      public function get imageBackground() : DisplayObject
      {
         return _imageBackground;
      }
      
      public function get clementineAsset() : DisplayObject
      {
         return _clementineAsset;
      }
      
      public function get goldFortuneAsset() : DisplayObject
      {
         return _goldFortuneAsset;
      }
      
      public function get awesomeButton() : Button
      {
         return _awesomeButton;
      }
   }
}

