package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileBeastConfirmationPopUp extends MobileClementineChangableActionPopUp
   {
      
      public static const HEAL_BEAST:int = 0;
      
      public static const INSTANT_EVOLVE:int = 1;
      
      public static const INSTANT_TRAIN:int = 2;
      
      private static const WINDOW_WIDTH:int = 592;
      
      private static const WINDOW_HEIGHT:int = 221;
      
      private var _confirmType:int;
      
      private var _finishNowPrice:int;
      
      public function MobileBeastConfirmationPopUp(param1:int, param2:int)
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         _confirmType = param1;
         _finishNowPrice = param2;
         if(_confirmType == 0)
         {
            var _loc5_:String = "m.ui.popups.beastconfirmation.healbeast.header";
            _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            var _temp_3:* = "m.ui.popups.beastconfirmation.healbeast.message";
            var _loc6_:String = param2 + "";
            var _loc7_:String = _temp_3;
            _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         }
         else if(_confirmType == 1)
         {
            var _loc8_:String = "m.ui.popups.beastconfirmation.instantevolve.header";
            _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            var _temp_4:* = "m.ui.popups.beastconfirmation.instantevolve.message";
            var _loc9_:String = param2 + "";
            var _loc10_:String = _temp_4;
            _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
         }
         else if(_confirmType == 2)
         {
            var _loc11_:String = "m.ui.popups.beastconfirmation.instanttrain.header";
            _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            var _temp_5:* = "m.ui.popups.beastconfirmation.instanttrain.message";
            var _loc12_:String = param2 + "";
            var _loc13_:String = _temp_5;
            _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_);
         }
         super(1,_loc4_,_loc3_,null,592,221);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 280;
         addChild(_actionButton);
         var _temp_2:* = _actionButton;
         var _loc1_:String = "m.ui.popups.boostConfirmation.buy";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _actionButton.rightLabel = String(_finishNowPrice);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_actionButton)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1) - 7);
         }
      }
      
      public function get confirmType() : int
      {
         return _confirmType;
      }
      
      override protected function getSpeechBubbleXIndent() : int
      {
         return 190;
      }
      
      override protected function getSpeechBubbleArrowYMargin() : int
      {
         if(_confirmType == 0)
         {
            return 53;
         }
         return 80;
      }
   }
}

