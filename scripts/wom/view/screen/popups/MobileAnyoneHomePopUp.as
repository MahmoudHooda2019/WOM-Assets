package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileAnyoneHomePopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 1005;
      
      private static const WINDOW_HEIGHT:int = 532;
      
      public function MobileAnyoneHomePopUp(param1:int = 1005, param2:int = 532)
      {
         var _loc4_:int;
         super(param1 >> 1,(_loc4_ = param2) >> 1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.anyonehome.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 373;
         var _loc2_:String = "ui.popups.anyonehome.message";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 351;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "ui.popups.anyonehome.sendfreegifts";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-135,-70);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,82,85);
         MobileAlignmentUtil.alignMiddleYAxisOf(_speechBubble,_background);
         _speechBubble.y -= 20;
         _speechBubble.speechArrowVerticalPosition = _speechBubble.height / 2 >> 1;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(actionButton,_background,205);
      }
   }
}

