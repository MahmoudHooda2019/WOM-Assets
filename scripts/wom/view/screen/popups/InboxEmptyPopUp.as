package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class InboxEmptyPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _princessAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _sendSomeGiftsButton:WomButton;
      
      public function InboxEmptyPopUp(param1:int = 586, param2:int = 306)
      {
         super(param1,param2,null,null,false);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.inbox.empty.title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _princessAsset = assetRepository.getDisplayObject("PoseMedium5");
         addChild(_princessAsset);
         var _temp_4:* = §§findproperty(SpeechBubbleView);
         var _temp_3:* = windowWidth - 255;
         var _loc2_:String = "ui.windows.inbox.empty.message";
         speechBubble = new SpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         addChild(speechBubble);
         _sendSomeGiftsButton = new WomBlueLargeButton();
         _sendSomeGiftsButton.width = 249;
         var _temp_7:* = _sendSomeGiftsButton;
         var _loc3_:String = "ui.windows.inbox.empty.sendsomegifts";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_sendSomeGiftsButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_princessAsset,_background,27,-51);
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _sendSomeGiftsButton.height / 8 >> 0;
         _sendSomeGiftsButton.x = windowWidth - _sendSomeGiftsButton.width >> 1;
         _sendSomeGiftsButton.y = windowHeight - 42;
      }
      
      public function get princessAsset() : AssetDisplayObject
      {
         return _princessAsset;
      }
      
      public function get sendSomeGiftsButton() : WomButton
      {
         return _sendSomeGiftsButton;
      }
   }
}

