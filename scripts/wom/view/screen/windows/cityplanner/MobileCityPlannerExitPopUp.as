package wom.view.screen.windows.cityplanner
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileCityPlannerExitPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 522;
      
      private static const WINDOW_HEIGHT:int = 243;
      
      private var _saveButton:MobileWomButton;
      
      public function MobileCityPlannerExitPopUp(param1:int = 522, param2:int = 243)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         addChild(_imageAsset);
         var _temp_3:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_2:* = 350;
         var _loc1_:String = "ui.windows.cityplanner.exitprompt";
         _speechBubble = new MobileSpeechBubbleView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),null,false,32,42,32);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 171;
         var _temp_6:* = _actionButton;
         var _loc2_:String = "m.ui.windows.cityplanner.yes";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_actionButton);
         _saveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _saveButton.width = 171;
         var _temp_8:* = _saveButton;
         var _loc3_:String = "m.ui.windows.cityplanner.no";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_saveButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12.5,_windowHeight - 15 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,136,46);
         MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,_background,(_windowWidth - totalWidthOfButtons()) / 2,_windowHeight - _actionButton.height / 2 - 13);
         MobileAlignmentUtil.alignRightOf(_saveButton,_actionButton,22);
      }
      
      private function totalWidthOfButtons() : Number
      {
         return _actionButton.width + _saveButton.width + 15;
      }
      
      public function get saveButton() : MobileWomButton
      {
         return _saveButton;
      }
      
      public function get discardButton() : MobileWomButton
      {
         return _actionButton;
      }
   }
}

