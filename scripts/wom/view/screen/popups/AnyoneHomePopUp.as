package wom.view.screen.popups
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class AnyoneHomePopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 450;
      
      private static const WINDOW_HEIGHT:int = 309;
      
      private var _imageBackground:DisplayObject;
      
      private var _workerAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _sendFreeGiftsButton:WomButton;
      
      public function AnyoneHomePopUp(param1:int = 450, param2:int = 309)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.anyonehome.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageBackground = assetRepository.getDisplayObject("PopupBackgroundMini");
         addChildAt(_imageBackground,1);
         _workerAsset = assetRepository.getDisplayObject("WorkerListen");
         addChild(_workerAsset);
         var _temp_5:* = §§findproperty(SpeechBubbleView);
         var _temp_4:* = 333;
         var _loc2_:String = "ui.popups.anyonehome.message";
         speechBubble = new SpeechBubbleView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _sendFreeGiftsButton = new WomBlueLargeButton();
         _sendFreeGiftsButton.width = 219;
         var _temp_8:* = _sendFreeGiftsButton;
         var _loc3_:String = "ui.popups.anyonehome.sendfreegifts";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_sendFreeGiftsButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,13,13);
         AlignmentUtil.alignAccordingToPositionOf(_workerAsset,_background,-126,2);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,76,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= 12;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_sendFreeGiftsButton,_background,263);
      }
      
      public function get workerAsset() : AssetDisplayObject
      {
         return _workerAsset;
      }
      
      public function get sendFreeGiftsButton() : WomButton
      {
         return _sendFreeGiftsButton;
      }
   }
}

