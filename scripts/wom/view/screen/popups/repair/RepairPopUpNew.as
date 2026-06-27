package wom.view.screen.popups.repair
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class RepairPopUpNew extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 442;
      
      private static const WINDOW_HEIGHT:int = 309;
      
      public static const TYPE_REPAIR_CONTINUING:int = 1;
      
      public static const TYPE_REPAIR_FINISHED:int = 2;
      
      public static const BUY_ITEM_ID:int = 2008;
      
      private var _type:int;
      
      private var _confirmButton:WomButton;
      
      private var _repairNowCost:int;
      
      private var popupBackground:DisplayObject;
      
      private var asset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      public function RepairPopUpNew(param1:int, param2:int = 0, param3:Vector.<WindowEnumeration> = null)
      {
         super(442,309,param3);
         _type = param1;
         _repairNowCost = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String;
         var _loc2_:String;
         setHeader(_type == 1 ? (_loc1_ = "ui.popups.repair.header1",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "ui.popups.repair.header2",peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         asset = assetRepository.getDisplayObject(_type == 1 ? "PoseMedium7" : "PoseMedium8");
         addChild(asset);
         var _loc3_:String;
         var _loc4_:String;
         speechBubble = new SpeechBubbleView(320,_type == 1 ? (_loc3_ = "ui.popups.repair.message1",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : (_loc4_ = "ui.popups.repair.message2",peak.i18n.PText.INSTANCE.getText0(_loc4_)),24,null,106);
         speechBubble.respectMargins = false;
         addChild(speechBubble);
         if(_type == 1)
         {
            _confirmButton = new WomGreenLargeButton();
            var _temp_4:* = _confirmButton;
            var _loc5_:String = "ui.popups.repair.repairnow";
            _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            _confirmButton.width = 275;
            _confirmButton.rightLabel = _repairNowCost + "";
            _confirmButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         }
         else
         {
            _confirmButton = new WomBlueLargeButton();
            _confirmButton.width = 190;
            var _temp_6:* = _confirmButton;
            var _loc6_:String = "ui.popups.repair.attacklogs";
            _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         addChild(_confirmButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         popupBackground = assetRepository.getDisplayObject(_type == 1 ? "CityUnderattackBackground" : "AfterBanditOutpostBackground");
         addChild(popupBackground);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(popupBackground,_background,12,12);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,74,93);
         if(_type == 1)
         {
            AlignmentUtil.alignAccordingToPositionOf(asset,_background,-74,-47);
         }
         else
         {
            AlignmentUtil.alignAccordingToPositionOf(asset,_background,-95,-67);
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_confirmButton,_background,_background.height - (_confirmButton.height >> 1));
      }
      
      public function get confirmButton() : Button
      {
         return _confirmButton;
      }
      
      public function get repairNowCost() : int
      {
         return _repairNowCost;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

