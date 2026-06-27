package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.resource.ResourceType;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileNotEnoughResourcePopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 575;
      
      private static const WINDOW_HEIGHT:int = 235;
      
      private var _resourceType:ResourceType;
      
      private var _unitTypeId:int;
      
      public function MobileNotEnoughResourcePopUp(param1:int, param2:ResourceType)
      {
         super(575,235);
         _unitTypeId = param1;
         _resourceType = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader));
         _speechBubble = new MobileSpeechBubbleView(390,"",null,false,20,30);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         addChild(_actionButton);
         switch(_resourceType)
         {
            case ResourceType.UNKNOWN:
               var _loc1_:String = "ui.popups.notenough.resource.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
               var _temp_5:* = speechBubble;
               var _loc2_:String = "m.ui.popups.notenough.resource.desc";
               _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               _actionButton.width = 315;
               var _temp_6:* = _actionButton;
               var _loc3_:String = "ui.popups.notenough.resource.ok";
               _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case ResourceType.IRON:
               var _loc4_:String = "ui.popups.notenough.iron.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
               var _temp_8:* = speechBubble;
               var _loc5_:String = "m.ui.popups.notenough.iron.desc";
               _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               _actionButton.width = 250;
               var _temp_9:* = _actionButton;
               var _loc6_:String = "ui.popups.notenough.iron.ok";
               _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               break;
            case ResourceType.MIGHT:
               var _loc7_:String = "ui.popups.notenough.might.header";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc7_));
               var _temp_11:* = speechBubble;
               var _loc8_:String = "m.ui.popups.notenough.might.desc";
               _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               _actionButton.width = 250;
               var _temp_12:* = _actionButton;
               var _loc9_:String = "ui.popups.notenough.might.ok";
               _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,-34);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,152,65);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,185);
         _speechBubble.speechArrowVerticalPosition = (_speechBubble.height - _speechBubble.speechBubbleArrow.height) / 2;
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

