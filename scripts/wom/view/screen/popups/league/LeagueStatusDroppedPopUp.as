package wom.view.screen.popups.league
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.util.GenericWindow;
   
   public class LeagueStatusDroppedPopUp extends GenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 442;
      
      protected static const WINDOW_HEIGHT:int = 309;
      
      private var _imageBackground:DisplayObject;
      
      protected var titleTextField:TextField;
      
      private var _descTextField:TextField;
      
      private var _okButton:Button;
      
      public function LeagueStatusDroppedPopUp()
      {
         super(442,309);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(getHeader());
         _imageBackground = assetRepository.getDisplayObject(getBackgroundAssetId());
         addChildAt(_imageBackground,1);
         titleTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         titleTextField.defaultTextFormat = getTitleTextFormat();
         titleTextField.multiline = true;
         titleTextField.wordWrap = true;
         titleTextField.autoSize = "center";
         titleTextField.width = 410;
         titleTextField.text = getTitle();
         addChild(titleTextField);
         _descTextField = new WomTextField();
         _descTextField.defaultTextFormat = getDescTextFormat();
         _descTextField.multiline = true;
         _descTextField.wordWrap = true;
         _descTextField.autoSize = "center";
         _descTextField.width = 410;
         _descTextField.text = getDesc();
         addChild(_descTextField);
         _okButton = new WomBlueLargeButton();
         _okButton.width = 185;
         _okButton.label = getOkButtonLabel();
         addChild(_okButton);
         drawLayout();
      }
      
      protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getBackgroundAssetId() : String
      {
         return "LeagueDropped";
      }
      
      protected function getTitle() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.title";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getTitleTextFormat() : TextFormat
      {
         return WomTextFormats.CENTER_22;
      }
      
      protected function getDesc() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.desc";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getDescTextFormat() : TextFormat
      {
         return WomTextFormats.CENTER_BOLD_20_WHITE;
      }
      
      protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.dropped.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,12,12);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,309 - 31);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_descTextField,_okButton,-_descTextField.height - 5);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(titleTextField,_descTextField,-titleTextField.height);
      }
      
      public function get imageBackground() : DisplayObject
      {
         return _imageBackground;
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
   }
}

