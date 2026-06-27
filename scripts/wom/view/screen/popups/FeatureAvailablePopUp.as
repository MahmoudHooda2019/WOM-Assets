package wom.view.screen.popups
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class FeatureAvailablePopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 530;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      public static const FORTIFY:int = 1;
      
      public static const CITY_PLANNER:int = 2;
      
      private var _clementineAsset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _okButton:WomButton;
      
      private var _type:int;
      
      public function FeatureAvailablePopUp(param1:int)
      {
         super(530,306);
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         super.initLayout();
         switch(_type - 1)
         {
            case 0:
               _loc1_ = "ui.popups.fortifyavailable.header";
               _loc2_ = "ui.popups.fortifyavailable.message";
               break;
            case 1:
               _loc1_ = "ui.popups.cityplannermoveavailable.header";
               _loc2_ = "ui.popups.cityplannermoveavailable.message";
         }
         var _loc3_:String = _loc1_;
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         _clementineAsset = assetRepository.getDisplayObject("PoseMedium3");
         addChild(_clementineAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 210;
         var _loc4_:String = _loc2_;
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc4_),26);
         addChild(speechBubble);
         _okButton = new WomBlueLargeButton();
         var _temp_7:* = _okButton;
         var _loc5_:String = "ui.popups.actionnotpossible.ok";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _okButton.width = 150;
         addChild(_okButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_clementineAsset,_background,-41,-55);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,170,65);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,windowHeight - 42);
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
   }
}

