package wom.view.screen.windows.tavern
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileTavernWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 837;
      
      private static const WINDOW_HEIGHT:int = 667;
      
      private var _tavernBackground:DisplayObject;
      
      private var _wheelView:MobileTavernWheelView;
      
      private var _tavernIndicator:DisplayObject;
      
      private var _spinButton:MobileWomButton;
      
      private var _beastDescTF:MPTextField;
      
      private var _giftView:MobileTavernGiftView;
      
      private var _unlockPanel:MobileTavernUnlockPanel;
      
      public function MobileTavernWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(837,667,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.tavern.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _tavernBackground = assetRepository.getDisplayObject("KompuGatchaBackground");
         addChild(_tavernBackground);
         _wheelView = new MobileTavernWheelView();
         addChild(_wheelView);
         _tavernIndicator = assetRepository.getDisplayObject("TavernIndicator");
         addChild(_tavernIndicator);
         _unlockPanel = new MobileTavernUnlockPanel();
         addChild(_unlockPanel);
         _beastDescTF = new MobileWomTextField();
         _beastDescTF.width = 320;
         _beastDescTF.textRendererProperties.textFormat = getWomTextFormat(21,"center",16777215);
         var _temp_7:* = _beastDescTF;
         var _loc2_:String = "ui.windows.tavern.unlock.desc";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_beastDescTF);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_tavernBackground,_background,38);
         MobileAlignmentUtil.alignAccordingToPositionOf(_wheelView,_background,417.5,223);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_tavernIndicator,_tavernBackground,545);
         _tavernIndicator.y -= 5;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unlockPanel,_background,473);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastDescTF,_background,450);
         if(_spinButton)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_spinButton,_tavernBackground,_tavernBackground.height - _spinButton.height / 2 - 10);
         }
         if(_giftView)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_giftView,_background,418,222);
         }
      }
      
      public function updateSpinButton(param1:Boolean = true, param2:int = 0) : void
      {
         if(_spinButton && contains(_spinButton))
         {
            removeChild(_spinButton);
         }
         if(param1)
         {
            var _temp_2:* = "Green";
            var _loc3_:String = "ui.windows.tavern.spin";
            initSpinButton(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc3_));
            _spinButton.defaultIcon = assetRepository.getDisplayObject("IconGoldS");
            _spinButton.rightLabel = String(param2);
         }
         else
         {
            var _temp_4:* = "Blue";
            var _loc4_:String = "ui.windows.tavern.freespin";
            initSpinButton(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         }
         addChild(_spinButton);
         drawLayout();
      }
      
      private function initSpinButton(param1:String, param2:String) : void
      {
         _spinButton = new MobileWomButton("",param1,"Large",getCaptionTextFormat(33),-5);
         _spinButton.height = 63;
         _spinButton.width = 166;
         _spinButton.label = param2;
      }
      
      public function updateGiftView(param1:TavernItemDIO) : void
      {
         if(_giftView && contains(_giftView))
         {
            removeChild(_giftView);
         }
         _giftView = new MobileTavernGiftView(param1);
         addChild(_giftView);
         setChildIndex(_giftView,getChildIndex(_spinButton) + 1);
         drawLayout();
      }
      
      public function get spinButton() : MobileWomButton
      {
         return _spinButton;
      }
      
      public function get wheelView() : MobileTavernWheelView
      {
         return _wheelView;
      }
   }
}

