package wom.view.screen.popups.levelup
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileLevelupPopup extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 590;
      
      private static const WINDOW_HEIGHT:int = 315;
      
      private var _levelUpMessageCaption:MPTextField;
      
      private var _levelIcon:DisplayObject;
      
      private var _levelCaption:MPTextField;
      
      private var _lightAnimation:MobileLightAnimationView;
      
      private var _level:int;
      
      public function MobileLevelupPopup(param1:int, param2:int = 590, param3:int = 315)
      {
         super(param2,param3);
         _level = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.levelup.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         addChild(_imageAsset);
         _lightAnimation = new MobileLightAnimationView();
         _lightAnimation.scaleX = _lightAnimation.scaleY = 2.5;
         addChild(_lightAnimation);
         var _temp_5:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_4:* = 385;
         var _loc2_:String = "ui.popups.levelup.keepup";
         _speechBubble = new MobileSpeechBubbleView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),getWomTextFormat(28,"center"),null,88,30,139);
         addChild(_speechBubble);
         _levelUpMessageCaption = new MobileCaptionTextField();
         _levelUpMessageCaption.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(_levelUpMessageCaption);
         var _temp_8:* = _levelUpMessageCaption;
         var _loc3_:String = "ui.popups.levelup.newlevel";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _levelIcon = assetRepository.getDisplayObject("IconLevelM");
         addChild(_levelIcon);
         _levelCaption = new MobileCaptionTextField();
         _levelCaption.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(_levelCaption);
         _levelCaption.text = _level.toString();
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 347;
         var _temp_12:* = _actionButton;
         var _loc4_:String = "ui.popups.levelup.share";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_actionButton);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,45);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,172,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(_lightAnimation,_speechBubble,_speechBubble.width >> 1,_speechBubble.height >> 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelUpMessageCaption,_speechBubble,_speechBubble.width - (_levelUpMessageCaption.width + _levelIcon.width + 5) >> 1,37);
         MobileAlignmentUtil.alignRightOf(_levelIcon,_levelUpMessageCaption,5);
         _levelIcon.y -= 15;
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelCaption,_levelIcon,26,29);
         _levelCaption.x -= _levelCaption.width / 2 + 3;
         _levelCaption.y -= _levelCaption.height / 2;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - (_actionButton.height >> 1) - 14);
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get lightAnimation() : MobileLightAnimationView
      {
         return _lightAnimation;
      }
   }
}

