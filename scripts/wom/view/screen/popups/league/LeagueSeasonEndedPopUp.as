package wom.view.screen.popups.league
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.util.GenericWindow;
   
   public class LeagueSeasonEndedPopUp extends GenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 442;
      
      protected static const WINDOW_HEIGHT:int = 309;
      
      private var _leagueLevelId:Number;
      
      private var _position:int;
      
      private var _seasonEndTime:Number;
      
      private var _imageBackground:DisplayObject;
      
      private var _titleTextField:TextField;
      
      protected var descTextField:TextField;
      
      private var _okButton:Button;
      
      public function LeagueSeasonEndedPopUp(param1:Number, param2:int, param3:Number)
      {
         super(442,309);
         _leagueLevelId = param1;
         _position = param2;
         _seasonEndTime = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(getHeader());
         _imageBackground = assetRepository.getDisplayObject(getBackgroundAssetId());
         addChildAt(_imageBackground,1);
         _titleTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         _titleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         _titleTextField.autoSize = "left";
         var _temp_5:* = _titleTextField;
         var _temp_4:* = "ui.windows.league.ended.title";
         var _temp_3:*;
         var _loc1_:String;
         var _loc2_:int;
         var _loc3_:String;
         var _loc4_:* = _position <= 3 ? (_loc1_ = "ui.common.position." + _position,peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_temp_3 = "ui.common.position.other",_loc2_ = _position,_loc3_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         var _loc5_:String = _temp_4;
         _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         addChild(_titleTextField);
         descTextField = new WomTextField();
         descTextField.defaultTextFormat = WomTextFormats.CENTER_BOLD_20_WHITE;
         descTextField.multiline = true;
         descTextField.wordWrap = true;
         descTextField.autoSize = "center";
         descTextField.width = 380;
         var _temp_8:* = descTextField;
         var _temp_7:* = "ui.windows.league.ended.desc";
         var _loc6_:String = DateTimeUtil.getFormattedDateFromMilliseconds(_seasonEndTime,".",4);
         var _loc7_:String = _temp_7;
         _temp_8.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         addChild(descTextField);
         _okButton = new WomBlueLargeButton();
         _okButton.width = 185;
         _okButton.label = getOkButtonLabel();
         addChild(_okButton);
         drawLayout();
      }
      
      protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.ended.notr.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getBackgroundAssetId() : String
      {
         return "SeasonEndNotr";
      }
      
      protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.ended.notr.done";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_imageBackground,_background,12,12);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_titleTextField,_background,33);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descTextField,_background,309 - descTextField.height - 45);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_okButton,_background,309 - 31);
      }
      
      public function get imageBackground() : DisplayObject
      {
         return _imageBackground;
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
      
      public function get leagueLevelId() : Number
      {
         return _leagueLevelId;
      }
      
      public function get position() : int
      {
         return _position;
      }
   }
}

