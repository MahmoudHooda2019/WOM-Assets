package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileLeaveGamePopUp extends MobileClementineChangableActionPopUp
   {
      
      private const WINDOW_WIDTH:int = 480;
      
      private const WINDOW_HEIGHT:int = 243;
      
      private var _leaveButton:MobileWomButton;
      
      public function MobileLeaveGamePopUp()
      {
         var _temp_3:* = this;
         var _temp_2:* = 2;
         var _loc1_:String = "m.ui.popups.leavegame.title";
         var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc2_:String = "m.ui.popups.leavegame.message";
         _temp_3.super(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,480,243);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _leaveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_2:* = _leaveButton;
         var _loc1_:String = "m.ui.popups.leavegame.button";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _leaveButton.width = 176;
         addChild(_leaveButton);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_leaveButton)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,134,50);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_leaveButton,_background,185);
         }
      }
      
      public function get leaveButton() : MobileWomButton
      {
         return _leaveButton;
      }
      
      override protected function getDescTextFieldWidth() : Number
      {
         return 290;
      }
   }
}

