package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.connection.DisconnectionReasonType;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileDisconnectPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 1130;
      
      private static const WINDOW_HEIGHT:int = 544;
      
      private var disconnectionReason:DisconnectionReasonType;
      
      public function MobileDisconnectPopUp(param1:DisconnectionReasonType, param2:int = 1130, param3:int = 544)
      {
         var _loc4_:int;
         var _loc5_:int;
         super((_loc4_ = param2) >> 1,(_loc5_ = param3) >> 1);
         this.disconnectionReason = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = disconnectionReason.headerI18nKey;
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker3");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 437;
         var _loc2_:String = disconnectionReason.disconnectionMessageI18nKey;
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 220;
         var _temp_7:* = _actionButton;
         var _loc3_:String = disconnectionReason.actionI18nKey;
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-150,-50);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,95,45);
         MobileAlignmentUtil.alignMiddleYAxisOf(_speechBubble,_background);
         _speechBubble.y -= 20;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,200);
      }
   }
}

