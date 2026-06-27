package wom.view.screen.popups.npcattack.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileNPCAttackRepelledPopup extends MobileBasePopUp
   {
      
      protected static const WINDOW_WIDTH:Number = 750;
      
      protected static const WINDOW_HEIGHT:Number = 384;
      
      public function MobileNPCAttackRepelledPopup(param1:Number = 750, param2:Number = 384)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.npcrepelled.thisisnotover";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("NPCAttackBackground");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 413;
         var _loc2_:String = "ui.popups.npcrepelled.message2";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,40,44,52);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 344;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "m.ui.popups.npcrepelled.illbewaiting2";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_imageAsset,_background);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,289,127);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1));
      }
   }
}

