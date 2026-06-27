package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileGenericStopPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 533;
      
      private static const WINDOW_HEIGHT:int = 216;
      
      private var _unitTypeId:int;
      
      public function MobileGenericStopPopUp(param1:int, param2:int = 533, param3:int = 216)
      {
         super(param2,param3);
         _unitTypeId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader("");
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         _speechBubble = new MobileSpeechBubbleView(344,"",null,false,28,36,52);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 182;
         var _temp_4:* = _actionButton;
         var _loc1_:String = "ui.popups.genericstop.stop";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,_windowHeight - 18 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,160,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2 - 6);
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

