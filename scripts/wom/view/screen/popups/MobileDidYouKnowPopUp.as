package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileDidYouKnowPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 660;
      
      private static const WINDOW_HEIGHT:int = 280;
      
      public function MobileDidYouKnowPopUp()
      {
         super(660,280);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.popups.didyouknow.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         addChild(_imageAsset);
         var _loc1_:int = 1 + 39 * Math.random();
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 470;
         var _loc3_:String = "ui.popups.didyouknow.message" + _loc1_;
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,false,30,35);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 200;
         var _temp_7:* = _actionButton;
         var _loc4_:String = "ui.popups.didyouknow.buttonlabel";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_actionButton);
         windowHeight = _speechBubble.height + 122;
         drawBackground();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_imageAsset,_background,-_imageAsset.width / 5 * 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,170,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - _actionButton.height / 2);
      }
   }
}

