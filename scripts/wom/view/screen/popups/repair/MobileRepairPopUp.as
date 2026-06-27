package wom.view.screen.popups.repair
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileRepairPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 693;
      
      private static const WINDOW_HEIGHT:int = 262;
      
      private var _repairDamageWithGoldButton:MobileWomButton;
      
      private var _repairNowCost:int;
      
      public function MobileRepairPopUp(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(693,262,param2);
         _repairNowCost = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.repair.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker3");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 470;
         var _loc2_:String = "ui.popups.repair.message";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,37,45);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 195;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "ui.popups.repair.repair";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         _repairDamageWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _repairDamageWithGoldButton.width = 400;
         var _temp_9:* = _repairDamageWithGoldButton;
         var _loc4_:String = "ui.popups.repair.repairnow";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _repairDamageWithGoldButton.rightLabel = _repairNowCost + "";
         _repairDamageWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _repairDamageWithGoldButton.iconOffsetY = 3;
         _repairDamageWithGoldButton.iconOffsetX = 18;
         _repairDamageWithGoldButton.invalidate("styles");
         addChild(_repairDamageWithGoldButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-120,-65);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,170,50);
         MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,_background,47,210);
         MobileAlignmentUtil.alignWidthSpecifiedRightOf(_repairDamageWithGoldButton,_actionButton,8,195);
      }
      
      public function get repairDamageWithGoldButton() : MobileWomButton
      {
         return _repairDamageWithGoldButton;
      }
      
      public function get repairNowCost() : int
      {
         return _repairNowCost;
      }
   }
}

