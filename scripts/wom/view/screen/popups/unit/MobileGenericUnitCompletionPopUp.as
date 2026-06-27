package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileGenericUnitCompletionPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 515;
      
      private static const WINDOW_HEIGHT:int = 274;
      
      protected var _unitTypeDIO:GenericUnitTypeDIO;
      
      public function MobileGenericUnitCompletionPopUp(param1:GenericUnitTypeDIO)
      {
         super(515,274);
         _unitTypeDIO = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _imageAsset = assetRepository.getDisplayObject(_unitTypeDIO.assetName);
         addChild(_imageAsset);
         _speechBubble = new MobileSpeechBubbleView(320,"",null,false,30,35);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 430;
         var _temp_4:* = _actionButton;
         var _loc1_:String = "ui.popups.unit.warnyourfriends";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,150,75);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,240);
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_speechBubble,-(_actionButton.width / 5) * 2,-(_imageAsset.height / 5) * 2);
      }
      
      public function get unitTypeDIO() : GenericUnitTypeDIO
      {
         return _unitTypeDIO;
      }
   }
}

