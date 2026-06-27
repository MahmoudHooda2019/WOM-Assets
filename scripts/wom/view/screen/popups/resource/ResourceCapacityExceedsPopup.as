package wom.view.screen.popups.resource
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.ui.common.OrView;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class ResourceCapacityExceedsPopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      public static const INVENTORY_ITEM:String = "inventory";
      
      public static const RECYCLE_BUILDING:String = "recycle";
      
      public static const CANCEL_HIRING:String = "cancel";
      
      public static const CANCEL_RECRUITMENT:String = "cancel";
      
      public static const CANCEL_TRAINING:String = "cancel";
      
      public static const CANCEL_CONSTRUCTION:String = "cancel";
      
      public static const CANCEL_EVENT_ITEM_BUILD:String = "blacksmith";
      
      private var _confirmButton:Button;
      
      private var _cancelButton:Button;
      
      private var _mercAsset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var orIcon:DisplayObject;
      
      private var _type:String;
      
      private var _confirmEvent:Event;
      
      private var _closeWindowEventType:String;
      
      public function ResourceCapacityExceedsPopup(param1:String, param2:Event, param3:String, param4:Vector.<WindowEnumeration> = null)
      {
         super(586,306,param4);
         _type = param1;
         _confirmEvent = param2;
         _closeWindowEventType = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.resourcecapacityexceeds.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercAsset = assetRepository.getDisplayObject("PoseMedium2");
         addChild(_mercAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 255;
         var _loc2_:String = "ui.popups.resourcecapacityexceeds.message." + _type;
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _confirmButton = new WomRedLargeButton();
         _confirmButton.width = 210;
         var _temp_7:* = _confirmButton;
         var _loc3_:String = "ui.popups.resourcecapacityexceeds.nevermind";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_confirmButton);
         _cancelButton = new WomGreenLargeButton();
         _cancelButton.width = 210;
         var _temp_9:* = _cancelButton;
         var _loc4_:String = "ui.popups.resourcecapacityexceeds.reconsider";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_cancelButton);
         orIcon = new OrView();
         addChild(orIcon);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _mercAsset.x = 20;
         _mercAsset.y = -64;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _cancelButton.height / 8 >> 0;
         _cancelButton.x = _windowWidth - totalButtonWidth >> 1;
         _cancelButton.y = _windowHeight - 42;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_cancelButton,11,-11);
         AlignmentUtil.alignRightOf(_confirmButton,_cancelButton,20);
      }
      
      public function get totalButtonWidth() : int
      {
         return _confirmButton.width + _cancelButton.width + 18;
      }
      
      public function get confirmButton() : Button
      {
         return _confirmButton;
      }
      
      public function get cancelButton() : Button
      {
         return _cancelButton;
      }
      
      public function get confirmEvent() : Event
      {
         return _confirmEvent;
      }
      
      public function get closeWindowEventType() : String
      {
         return _closeWindowEventType;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}

