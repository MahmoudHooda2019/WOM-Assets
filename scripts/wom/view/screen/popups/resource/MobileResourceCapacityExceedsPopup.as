package wom.view.screen.popups.resource
{
   import flash.events.Event;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileResourceCapacityExceedsPopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 610;
      
      private static const WINDOW_HEIGHT:int = 245;
      
      public static const INVENTORY_ITEM:String = "inventory";
      
      public static const RECYCLE_BUILDING:String = "recycle";
      
      public static const CANCEL_HIRING:String = "cancel";
      
      public static const CANCEL_RECRUITMENT:String = "cancel";
      
      public static const CANCEL_TRAINING:String = "cancel";
      
      public static const CANCEL_CONSTRUCTION:String = "cancel";
      
      public static const CANCEL_EVENT_ITEM_BUILD:String = "blacksmith";
      
      private var _type:String;
      
      private var _confirmEvent:Event;
      
      private var _closeWindowEventType:String;
      
      private var _reconsiderButton:MobileWomButton;
      
      public function MobileResourceCapacityExceedsPopup(param1:String, param2:Event, param3:String, param4:Vector.<WindowEnumeration> = null, param5:int = 610, param6:int = 245)
      {
         super(param5,param6,param4);
         _type = param1;
         _confirmEvent = param2;
         _closeWindowEventType = param3 != null ? param3 : "closePopUpWindow";
      }
      
      override protected function initLayout() : void
      {
         var _loc1_:String = null;
         super.initLayout();
         var _loc2_:String = "m.ui.popups.resourcecapacityexceeds.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _imageAsset = assetRepository.getDisplayObject("MPose2Left");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         _loc2_ = _type;
         if("recycle" !== _loc2_)
         {
            var _loc4_:String = "ui.popups.resourcecapacityexceeds.message." + _type;
            _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else
         {
            var _loc3_:String = "m.ui.popups.resourcecapacityexceeds.message." + _type;
            _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         }
         _speechBubble = new MobileSpeechBubbleView(windowWidth - 211,_loc1_,null,false,38,53,64);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 254;
         var _temp_5:* = _actionButton;
         var _loc5_:String = "ui.popups.resourcecapacityexceeds.nevermind";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_actionButton);
         _reconsiderButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _reconsiderButton.width = 261;
         var _temp_7:* = _reconsiderButton;
         var _loc6_:String = "ui.popups.resourcecapacityexceeds.reconsider";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_reconsiderButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,12,_windowHeight - 18 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,177,36);
         MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,_background,(_windowWidth - totalWidthOfButtons()) / 2,_windowHeight - _actionButton.height / 2);
         MobileAlignmentUtil.alignRightOf(_reconsiderButton,_actionButton,6);
      }
      
      private function totalWidthOfButtons() : Number
      {
         return _actionButton.width + _reconsiderButton.width + 22;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get confirmEvent() : Event
      {
         return _confirmEvent;
      }
      
      public function get closeWindowEventType() : String
      {
         return _closeWindowEventType;
      }
      
      public function get reconsiderButton() : MobileWomButton
      {
         return _reconsiderButton;
      }
      
      public function get confirmButton() : MobileWomButton
      {
         return _actionButton;
      }
   }
}

