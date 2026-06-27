package wom.view.screen.popups.league
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileLeagueStatusDroppedPopUp extends MobileGenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 611;
      
      protected static const WINDOW_HEIGHT:int = 430;
      
      private var _imageBackground:DisplayObject;
      
      protected var _shieldBackground:DisplayObject;
      
      private var _titleTextField:MPTextField;
      
      protected var descTextField:MPTextField;
      
      private var _okButton:MPButton;
      
      public function MobileLeagueStatusDroppedPopUp()
      {
         super(611,430);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(getHeader());
         _titleTextField = new MobileCaptionTextField();
         _titleTextField.textRendererProperties.textFormat = getTitleTextFormat();
         _titleTextField.textRendererProperties.wordWrap = true;
         _titleTextField.width = 480;
         addChild(_titleTextField);
         _titleTextField.text = getTitle();
         descTextField = new MobileWomTextField();
         descTextField.textRendererProperties.textFormat = getDescTextFormat();
         descTextField.textRendererProperties.wordWrap = true;
         descTextField.width = 460;
         addChild(descTextField);
         descTextField.text = getDesc();
         _okButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _okButton.width = 244;
         _okButton.label = getOkButtonLabel();
         addChild(_okButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         _imageBackground = assetRepository.getDisplayObject(getBackgroundAssetId());
         addChild(_imageBackground);
         _shieldBackground = assetRepository.getDisplayObject("LeagueBlankShield");
         addChild(_shieldBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(_shieldBackground,_imageBackground,207,67);
      }
      
      protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getBackgroundAssetId() : String
      {
         return "LeagueBackground";
      }
      
      protected function getTitle() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.title";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getTitleTextFormat() : MPBitmapFontTextFormat
      {
         return getCaptionTextFormat(27,"center");
      }
      
      protected function getDesc() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.desc";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getDescTextFormat() : MPBitmapFontTextFormat
      {
         return getWomTextFormat(25,"center",16777215);
      }
      
      protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,14,14);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_titleTextField,_background,260);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_background,430 - descTextField.height - 75);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,430 - 58);
      }
      
      public function get imageBackground() : DisplayObject
      {
         return _imageBackground;
      }
      
      public function get okButton() : MPButton
      {
         return _okButton;
      }
      
      public function get titleTextField() : MPTextField
      {
         return _titleTextField;
      }
   }
}

