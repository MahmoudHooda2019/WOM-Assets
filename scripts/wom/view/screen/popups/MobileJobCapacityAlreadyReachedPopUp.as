package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileSpeechBubbleView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileJobCapacityAlreadyReachedPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 734;
      
      private static const WINDOW_HEIGHT:int = 333;
      
      private var _mercenaryAsset:DisplayObject;
      
      private var speechBubble:MobileSpeechBubbleView;
      
      private var _speedUpButton:MobileWomButton;
      
      private var _hireExtraWorkerButton:MobileWomButton;
      
      public function MobileJobCapacityAlreadyReachedPopUp(param1:Vector.<WindowEnumeration> = null)
      {
         super(734,333,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.actionnotpossible.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercenaryAsset = assetRepository.getDisplayObject("PoseWorker4");
         _staticLayer.addChildAt(_mercenaryAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 453;
         var _loc2_:String = "ui.popups.workerjobcapacityreached.desc";
         speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _speedUpButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _speedUpButton.width = 237;
         addChild(_speedUpButton);
         var _temp_7:* = _speedUpButton;
         var _loc3_:String = "ui.popups.workerjobcapacityreached.speedup";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _hireExtraWorkerButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _hireExtraWorkerButton.width = 430;
         addChild(_hireExtraWorkerButton);
         var _temp_9:* = _hireExtraWorkerButton;
         var _loc4_:String = "ui.popups.workerjobcapacityreached.hireextraworker";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_mercenaryAsset,_background,-85,-124);
         MobileAlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,230,70);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speedUpButton,_background,_background.width - totalButtonWidth >> 1,_background.height - (_speedUpButton.height >> 1));
         MobileAlignmentUtil.alignRightOf(_hireExtraWorkerButton,_speedUpButton,14);
      }
      
      public function get totalButtonWidth() : int
      {
         return _hireExtraWorkerButton.visible ? _speedUpButton.width + _hireExtraWorkerButton.width + 14 : _speedUpButton.width;
      }
      
      public function get mercenaryAsset() : DisplayObject
      {
         return _mercenaryAsset;
      }
      
      public function updateWithWorkerInfo(param1:int) : void
      {
         _hireExtraWorkerButton.visible = param1 < 5;
         drawLayout();
      }
      
      public function get speedUpButton() : MobileWomButton
      {
         return _speedUpButton;
      }
      
      public function get hireExtraWorkerButton() : MobileWomButton
      {
         return _hireExtraWorkerButton;
      }
   }
}

