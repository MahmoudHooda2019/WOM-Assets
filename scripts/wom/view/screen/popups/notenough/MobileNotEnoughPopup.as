package wom.view.screen.popups.notenough
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.gold.MonetizationType;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileNotEnoughPopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 574;
      
      private static const WINDOW_HEIGHT:int = 216;
      
      public static const NOT_ENOUGH_RECON_POINTS:String = "recon";
      
      public static const NOT_ENOUGH_GOLD:String = "gold";
      
      public static const NOT_ENOUGH_EVENT_POINTS:String = "event";
      
      private var _type:String;
      
      private var _monetizationType:MonetizationType;
      
      public function MobileNotEnoughPopup(param1:String, param2:MonetizationType = null, param3:int = 574, param4:int = 216)
      {
         super(param3,param4);
         _type = param1;
         _monetizationType = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.notenough." + _type + ".header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _temp_3:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_2:* = _windowWidth - 188;
         var _loc2_:String = "ui.popups.notenough." + _type + ".desc";
         _speechBubble = new MobileSpeechBubbleView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,42,50,52);
         switch(_type)
         {
            case "recon":
               _imageAsset = assetRepository.getDisplayObject("MPose5Left");
               _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
               _actionButton.width = 200;
               var _temp_7:* = _actionButton;
               var _loc3_:String = "ui.popups.notenough.recon.ok";
               _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case "event":
               _imageAsset = assetRepository.getDisplayObject("MPose2Left");
               _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
               _actionButton.width = 200;
               var _temp_10:* = _actionButton;
               var _loc4_:String = "ui.popups.notenough.recon.ok";
               _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case "gold":
               _imageAsset = assetRepository.getDisplayObject("MPose2Left");
               _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
               _actionButton.width = 200;
               var _temp_13:* = _actionButton;
               var _loc5_:String = "ui.popups.notenough.gold.ok";
               _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         addChild(_speechBubble);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         alignImageAsset();
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,153,45);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,153,45);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1));
      }
      
      private function alignImageAsset() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         switch(_type)
         {
            case "gold":
            case "recon":
               _loc1_ = 10.5;
               break;
            case "event":
         }
         _loc2_ = _windowHeight - 18 - _imageAsset.height;
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,_loc1_,_loc2_);
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get monetizationType() : MonetizationType
      {
         return _monetizationType;
      }
   }
}

