package wom.view.screen.popups.unit
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class GenericNotEnoughPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _unitTypeId:int;
      
      private var _workerAsset:DisplayObject;
      
      protected var speechBubble:SpeechBubbleView;
      
      protected var _okButton:Button;
      
      public function GenericNotEnoughPopUp(param1:int)
      {
         super(586,306);
         _unitTypeId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _workerAsset = assetRepository.getDisplayObject("WorkerNormal");
         addChild(_workerAsset);
         speechBubble = new SpeechBubbleView(windowWidth - 255,"");
         addChild(speechBubble);
         _okButton = new WomGreenLargeButton();
         addChild(_okButton);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_workerAsset,_background,-95,-79);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _okButton.height / 8 >> 0;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,274);
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
      
      public function get workerAsset() : DisplayObject
      {
         return _workerAsset;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

