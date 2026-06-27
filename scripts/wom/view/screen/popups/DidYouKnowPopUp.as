package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class DidYouKnowPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 640;
      
      private static const WINDOW_HEIGHT:int = 229;
      
      private var _beastAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _awesomeButton:WomButton;
      
      public function DidYouKnowPopUp(param1:int = 640, param2:int = 229)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.popups.didyouknow.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _beastAsset = assetRepository.getDisplayObject("Bearwolf6");
         addChildAt(_beastAsset,getChildIndex(_windowHeader));
         var _loc1_:int = 1 + 39 * Math.random();
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 255;
         var _loc3_:String = "ui.popups.didyouknow.message" + _loc1_;
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc3_));
         addChild(speechBubble);
         _awesomeButton = new WomBlueLargeButton();
         _awesomeButton.width = 249;
         var _temp_7:* = _awesomeButton;
         var _loc4_:String = "ui.popups.didyouknow.buttonlabel";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_awesomeButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_beastAsset,_background,-141,-43);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _awesomeButton.height / 8 >> 0;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_awesomeButton,_background,186);
      }
      
      public function get beastAsset() : AssetDisplayObject
      {
         return _beastAsset;
      }
      
      public function get awesomeButton() : WomButton
      {
         return _awesomeButton;
      }
   }
}

