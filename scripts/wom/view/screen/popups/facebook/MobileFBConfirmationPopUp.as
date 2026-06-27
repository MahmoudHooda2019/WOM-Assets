package wom.view.screen.popups.facebook
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFBConfirmationPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 632;
      
      private static const WINDOW_HEIGHT:int = 274;
      
      private var _oldLevelStr:String;
      
      private var _newLevelStr:String;
      
      private var _isWebSelected:Boolean;
      
      private var _positiveButton:MobileWomButton;
      
      public function MobileFBConfirmationPopUp(param1:String, param2:String, param3:Boolean, param4:int = 632, param5:int = 274)
      {
         super(param4,param5,null,false);
         _oldLevelStr = param3 ? param2 : param1;
         _newLevelStr = param3 ? param1 : param2;
         _isWebSelected = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.popups.facebookConfirmation.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         addChild(_imageAsset);
         var _temp_6:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_5:* = 429;
         var _temp_4:* = "m.ui.popups.facebookConfirmation.message";
         var _temp_3:* = _newLevelStr;
         var _loc2_:String = _oldLevelStr;
         var _loc3_:String = _temp_3;
         var _loc4_:String = _temp_4;
         _speechBubble = new MobileSpeechBubbleView(_temp_5,peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_),null,false,43,52,52);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 165;
         var _temp_9:* = _actionButton;
         var _loc5_:String = "m.ui.popups.facebookConfirmation.negative";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_actionButton);
         _positiveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _positiveButton.width = 165;
         var _temp_11:* = _positiveButton;
         var _loc6_:String = "m.ui.popups.facebookConfirmation.positive";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_positiveButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,_windowHeight - 9 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,165,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,_background,(_windowWidth - totalWidthOfButtons()) / 2,_windowHeight - _actionButton.height / 2 - 13);
         MobileAlignmentUtil.alignRightOf(_positiveButton,_actionButton,22);
      }
      
      private function totalWidthOfButtons() : Number
      {
         return _actionButton.width + _positiveButton.width + 22;
      }
      
      public function get positiveButton() : MobileWomButton
      {
         return _positiveButton;
      }
      
      public function get negativeButton() : MobileWomButton
      {
         return _actionButton;
      }
      
      public function get isWebSelected() : Boolean
      {
         return _isWebSelected;
      }
   }
}

