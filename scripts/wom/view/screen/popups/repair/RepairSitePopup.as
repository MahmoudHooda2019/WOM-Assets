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
   import wom.view.ui.common.OrView;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class RepairSitePopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _mercenaryAsset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _speedUpButton:WomButton;
      
      private var _repairAllButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _instanceId:int;
      
      private var _repairAllValue:int;
      
      public function RepairSitePopup(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(586,306,param2);
         this._instanceId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.repairsite.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercenaryAsset = assetRepository.getDisplayObject("WorkerNormal");
         addChild(_mercenaryAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 255;
         var _loc2_:String = "ui.popups.repairsite.message";
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _speedUpButton = new WomBlueLargeButton();
         var _temp_7:* = _speedUpButton;
         var _loc3_:String = "ui.popups.repairsite.speedup";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _speedUpButton.width = 150;
         addChild(_speedUpButton);
         _repairAllButton = new WomGreenLargeButton();
         var _temp_9:* = _repairAllButton;
         var _loc4_:String = "ui.popups.repairsite.repairall";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _repairAllButton.width = 279;
         _repairAllButton.rightLabel = "0";
         _repairAllButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         addChild(_repairAllButton);
         orIcon = new OrView();
         addChild(orIcon);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _mercenaryAsset.x = -95;
         _mercenaryAsset.y = -79;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _speedUpButton.height / 8 >> 0;
         _speedUpButton.x = 71;
         _speedUpButton.y = 264;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_speedUpButton,11,-11);
         AlignmentUtil.alignRightOf(_repairAllButton,_speedUpButton,18);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get speedUpButton() : Button
      {
         return _speedUpButton;
      }
      
      public function get repairAllButton() : Button
      {
         return _repairAllButton;
      }
      
      public function get mercenaryAsset() : DisplayObject
      {
         return _mercenaryAsset;
      }
      
      public function updateData(param1:int) : void
      {
         _repairAllValue = param1;
         _repairAllButton.rightLabel = param1 + "";
      }
      
      public function get repairAllValue() : int
      {
         return _repairAllValue;
      }
   }
}

