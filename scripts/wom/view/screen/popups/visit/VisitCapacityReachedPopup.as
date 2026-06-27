package wom.view.screen.popups.visit
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class VisitCapacityReachedPopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _okButton:Button;
      
      private var clementineAsset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      public function VisitCapacityReachedPopup()
      {
         super(586,306);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.visitlimitexceeds.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         clementineAsset = assetRepository.getDisplayObject("PoseMedium2");
         addChild(clementineAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 255;
         var _loc2_:String = "ui.popups.visitlimitexceeds.message";
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _okButton = new WomBlueLargeButton();
         _okButton.width = 210;
         var _temp_7:* = _okButton;
         var _loc3_:String = "ui.popups.visitlimitexceeds.ok";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_okButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         clementineAsset.x = 20;
         clementineAsset.y = -64;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _okButton.height / 8 >> 0;
         _okButton.x = _windowWidth - _okButton.width >> 1;
         _okButton.y = _windowHeight - 42;
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
   }
}

