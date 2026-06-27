package wom.view.screen.popups.league
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileLeagueSeasonEndedPopUp extends MobileGenericWindow
   {
      
      protected static const WINDOW_WIDTH:int = 611;
      
      protected static const WINDOW_HEIGHT:int = 430;
      
      private var _leagueLevelId:Number;
      
      private var _position:int;
      
      private var _seasonEndTime:Number;
      
      private var _imageBackground:DisplayObject;
      
      private var _shieldBackground:DisplayObject;
      
      protected var _workerAsset:DisplayObject;
      
      private var _titleTextField:MPTextField;
      
      protected var descTextField:MPTextField;
      
      private var _okButton:MPButton;
      
      public function MobileLeagueSeasonEndedPopUp(param1:Number, param2:int, param3:Number)
      {
         super(611,430);
         _leagueLevelId = param1;
         _position = param2;
         _seasonEndTime = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(getHeader());
         _titleTextField = new MobileCaptionTextField();
         _titleTextField.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         addChild(_titleTextField);
         var _temp_4:* = _titleTextField;
         var _temp_3:* = "ui.windows.league.ended.title";
         var _temp_2:*;
         var _loc1_:String;
         var _loc2_:int;
         var _loc3_:String;
         var _loc4_:* = _position <= 3 ? (_loc1_ = "ui.common.position." + _position,peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_temp_2 = "ui.common.position.other",_loc2_ = _position,_loc3_ = _temp_2,peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         var _loc5_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         descTextField = new MobileWomTextField();
         descTextField.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         descTextField.textRendererProperties.wordWrap = true;
         descTextField.width = 460;
         addChild(descTextField);
         var _temp_7:* = descTextField;
         var _temp_6:* = "ui.windows.league.ended.desc";
         var _loc6_:String = DateTimeUtil.getFormattedDateFromMilliseconds(_seasonEndTime,".",4);
         var _loc7_:String = _temp_6;
         _temp_7.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
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
         MobileAlignmentUtil.alignAccordingToPositionOf(_shieldBackground,_imageBackground,204,70);
         _workerAsset = assetRepository.getDisplayObject("PoseWorker3");
         addChild(_workerAsset);
         MobileAlignmentUtil.alignAccordingToPositionOf(_workerAsset,_imageBackground,-180,14);
      }
      
      protected function getHeader() : String
      {
         var _loc1_:String = "ui.windows.league.ended.notr.header";
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      protected function getBackgroundAssetId() : String
      {
         return "LeagueBackground";
      }
      
      protected function getOkButtonLabel() : String
      {
         var _loc1_:String = "ui.windows.league.ended.notr.mdone";
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
      
      public function get leagueLevelId() : Number
      {
         return _leagueLevelId;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get titleTextField() : MPTextField
      {
         return _titleTextField;
      }
   }
}

