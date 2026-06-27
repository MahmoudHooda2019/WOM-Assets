package wom.view.screen.popups
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
   
   public class JobCapacityAlreadyReachedPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _mercenaryAsset:DisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _speedUpButton:WomButton;
      
      private var _hireExtraWorkerButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      public function JobCapacityAlreadyReachedPopUp(param1:Vector.<WindowEnumeration> = null)
      {
         super(586,306,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.actionnotpossible.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercenaryAsset = assetRepository.getDisplayObject("WorkerNormal");
         addChild(_mercenaryAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = _windowWidth - 255;
         var _loc2_:String = "ui.popups.workerjobcapacityreached.desc";
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _speedUpButton = new WomBlueLargeButton();
         var _temp_7:* = _speedUpButton;
         var _loc3_:String = "ui.popups.workerjobcapacityreached.speedup";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _speedUpButton.width = 215;
         addChild(_speedUpButton);
         _hireExtraWorkerButton = new WomGreenLargeButton();
         var _temp_9:* = _hireExtraWorkerButton;
         var _loc4_:String = "ui.popups.workerjobcapacityreached.hireextraworker";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _hireExtraWorkerButton.width = 280;
         addChild(_hireExtraWorkerButton);
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
         _speedUpButton.x = _windowWidth - totalButtonWidth >> 1;
         _speedUpButton.y = _windowHeight - 42;
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_speedUpButton,11,-11);
         AlignmentUtil.alignRightOf(_hireExtraWorkerButton,_speedUpButton,18);
      }
      
      public function get totalButtonWidth() : int
      {
         return _hireExtraWorkerButton.visible ? _speedUpButton.width + _hireExtraWorkerButton.width + 18 : _speedUpButton.width;
      }
      
      public function get speedUpButton() : Button
      {
         return _speedUpButton;
      }
      
      public function get hireExtraWorkerButton() : Button
      {
         return _hireExtraWorkerButton;
      }
      
      public function get mercenaryAsset() : DisplayObject
      {
         return _mercenaryAsset;
      }
      
      public function updateWithWorkerInfo(param1:int) : void
      {
         _hireExtraWorkerButton.visible = orIcon.visible = param1 < 5;
         drawLayout();
      }
   }
}

