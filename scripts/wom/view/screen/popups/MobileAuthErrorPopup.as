package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileAuthErrorPopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 560;
      
      private static const WINDOW_HEIGHT:int = 267;
      
      private var _errorCode:int;
      
      public function MobileAuthErrorPopup(param1:int, param2:int = 560, param3:* = 267)
      {
         super(param2,param3);
         _errorCode = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.autherror.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker3");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 467;
         var _loc2_:String = "ui.popups.autherror.message." + _errorCode;
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,41,37,52);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 243;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "ui.popups.autherror.tryagain";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-215,-63);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,53,47);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2);
      }
   }
}

