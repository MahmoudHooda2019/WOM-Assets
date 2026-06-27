package wom.view.screen.popups.notenough
{
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.gold.MonetizationType;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class NotEnoughPopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_WIDTH_GOLD:int = 554;
      
      private static const WINDOW_HEIGHT:int = 229;
      
      public static const NOT_ENOUGH_RECON_POINTS:String = "recon";
      
      public static const NOT_ENOUGH_GOLD:String = "gold";
      
      public static const NOT_ENOUGH_EVENT_POINTS:String = "event";
      
      private var _type:String;
      
      private var _monetizationType:MonetizationType;
      
      private var _unitAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _okButton:WomButton;
      
      public function NotEnoughPopup(param1:String, param2:MonetizationType = null)
      {
         super(param1 == "gold" ? 554 : 586,229);
         _monetizationType = param2 == null ? MonetizationType.NOT_ENOUGH_GOLD : param2;
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.notenough." + _type + ".header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _temp_3:* = §§findproperty(SpeechBubbleView);
         var _temp_2:* = _windowWidth - 255;
         var _loc2_:String = "ui.popups.notenough." + _type + ".desc";
         speechBubble = new SpeechBubbleView(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc2_),24);
         addChild(speechBubble);
         switch(_type)
         {
            case "recon":
               _unitAsset = assetRepository.getDisplayObject("PersianSapperFull");
               _unitAsset.scaleX = _unitAsset.scaleY = 0.809;
               _okButton = new WomBlueLargeButton();
               _okButton.width = 139;
               var _temp_7:* = _okButton;
               var _loc3_:String = "ui.popups.notenough.recon.ok";
               _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case "event":
               _unitAsset = assetRepository.getDisplayObject("PoseSmall2");
               _okButton = new WomBlueLargeButton();
               _okButton.width = 139;
               var _temp_10:* = _okButton;
               var _loc4_:String = "ui.popups.notenough.recon.ok";
               _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case "gold":
               _unitAsset = assetRepository.getDisplayObject("PoseMedium6");
               _okButton = new WomGreenLargeButton();
               _okButton.width = 189;
               _okButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
               var _temp_13:* = _okButton;
               var _loc5_:String = "ui.popups.notenough.gold.ok";
               _temp_13.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         addChild(_unitAsset);
         addChild(_okButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _unitAsset.x = _type == "recon" ? -97 : (_type == "event" ? -2 : -71);
         _unitAsset.y = _type == "recon" ? -6 : (_type == "event" ? 8 : -41);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,173,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _okButton.height / 8 >> 0;
         _okButton.y = 186;
         _okButton.x = (_windowWidth - _okButton.width) / 2 << 0;
      }
      
      public function get unitAsset() : AssetDisplayObject
      {
         return _unitAsset;
      }
      
      public function get okButton() : WomButton
      {
         return _okButton;
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

