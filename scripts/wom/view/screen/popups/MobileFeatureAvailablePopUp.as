package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFeatureAvailablePopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 577;
      
      private static const WINDOW_HEIGHT:int = 247;
      
      public static const FORTIFY:int = 1;
      
      public static const CITY_PLANNER:int = 2;
      
      private var _type:int;
      
      public function MobileFeatureAvailablePopUp(param1:int, param2:int = 577, param3:int = 247)
      {
         super(param2,param3);
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = null;
         super.initLayout();
         switch(_type - 1)
         {
            case 0:
               var _loc3_:String = "ui.popups.fortifyavailable.header";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               var _loc4_:String = "ui.popups.fortifyavailable.message";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 1:
               var _loc5_:String = "ui.popups.cityplannermoveavailable.header";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               var _loc6_:String = "ui.popups.cityplannermoveavailable.message";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         setHeader(_loc2_);
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         addChild(_imageAsset);
         _speechBubble = new MobileSpeechBubbleView(windowWidth - 178,_loc1_,null,false,30,35,64);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_4:* = _actionButton;
         var _loc7_:String = "ui.popups.actionnotpossible.ok";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _actionButton.width = 180;
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,_windowHeight - 8 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,146,39);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2 - 6);
      }
   }
}

