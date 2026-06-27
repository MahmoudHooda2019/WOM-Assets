package wom.view.screen.popups.unit
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.util.GenericWindow;
   
   public class GenericUnitCompletionPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 584;
      
      private static const WINDOW_HEIGHT:int = 180;
      
      private var _unitTypeDIO:GenericUnitTypeDIO;
      
      private var _unitAsset:AssetDisplayObject;
      
      protected var messageField:TextField;
      
      private var _warnYourFriendsButton:WomButton;
      
      public function GenericUnitCompletionPopUp(param1:GenericUnitTypeDIO, param2:int = 584, param3:int = 180)
      {
         super(param2,param3);
         _unitTypeDIO = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _unitAsset = assetRepository.getDisplayObject(_unitTypeDIO.assetName + "Popup");
         addChild(_unitAsset);
         messageField = new WomTextField();
         messageField.multiline = true;
         messageField.wordWrap = true;
         messageField.width = 300;
         messageField.defaultTextFormat = WomTextFormats.CENTER_28;
         messageField.autoSize = "center";
         addChild(messageField);
         _warnYourFriendsButton = new WomBlueLargeButton();
         _warnYourFriendsButton.width = 289;
         var _temp_4:* = _warnYourFriendsButton;
         var _loc1_:String = "ui.popups.unit.warnyourfriends";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_warnYourFriendsButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_unitAsset,_background,-45,-108);
         AlignmentUtil.alignAccordingToPositionOf(messageField,_background,250,0);
         AlignmentUtil.alignMiddleYAxisOf(messageField,_background);
         messageField.y -= _warnYourFriendsButton.height / 8 >> 0;
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_warnYourFriendsButton,_background,138);
      }
      
      public function get unitAsset() : AssetDisplayObject
      {
         return _unitAsset;
      }
      
      public function get warnYourFriendsButton() : WomButton
      {
         return _warnYourFriendsButton;
      }
      
      public function get unitTypeDIO() : GenericUnitTypeDIO
      {
         return _unitTypeDIO;
      }
   }
}

