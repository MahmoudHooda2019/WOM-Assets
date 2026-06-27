package wom.view.screen.popups.facebook
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFBProgressPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 561;
      
      private static const WINDOW_HEIGHT:int = 376;
      
      private var _isWebRecommended:Boolean;
      
      private var _webLevel:String;
      
      private var _mobileLevel:String;
      
      private var _progressBG:DisplayObject;
      
      private var _switchProgressChoiceButton:MPRigidButton;
      
      private var _recommendationTF:MPTextField;
      
      private var _progressCaption:MobileCaptionTextField;
      
      private var _fbIcon:DisplayObject;
      
      private var _levelStarIcon:DisplayObject;
      
      private var _levelTF:MPTextField;
      
      private var _isWebSelected:Boolean;
      
      public function MobileFBProgressPopUp(param1:int, param2:int, param3:Boolean, param4:int = 561, param5:int = 376)
      {
         super(param4,param5,null,false);
         _isWebRecommended = param3;
         _webLevel = param1.toString();
         _mobileLevel = param2.toString();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.popups.facebookProgress.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker4");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = windowWidth - 84;
         var _loc2_:String = "m.ui.popups.facebookProgress.message";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,41,40,52);
         addChild(_speechBubble);
         _progressBG = assetRepository.getDisplayObject("MobileDarkBackground");
         _progressBG.width = 330;
         _progressBG.height = 120;
         addChild(_progressBG);
         _recommendationTF = new MobileWomTextField();
         _progressCaption = new MobileCaptionTextField();
         _switchProgressChoiceButton = new MPRigidButton("ArrowBlue","ArrowBlue");
         _levelTF = new MobileCaptionTextField();
         _levelStarIcon = assetRepository.getDisplayObject("IconLevelM");
         _levelTF.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         if(_isWebRecommended)
         {
            showWebAccount();
            addChild(_fbIcon);
         }
         else
         {
            showGuestAccount();
         }
         addChild(_recommendationTF);
         addChild(_progressCaption);
         addChild(_levelStarIcon);
         addChild(_levelTF);
         addChild(_switchProgressChoiceButton);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_13:* = _actionButton;
         var _loc3_:String = "m.ui.popups.facebookProgress.continue";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _actionButton.width = 247;
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _recommendationTF.validate();
         _progressCaption.validate();
         _switchProgressChoiceButton.validate();
         _levelTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-174,-77);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_speechBubble,_background,48);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_progressBG,_background,182);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_recommendationTF,_progressBG,12);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_levelStarIcon,_progressBG,61);
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelTF,_levelStarIcon,26,28);
         _levelTF.y -= _levelTF.height / 2;
         _levelTF.x -= _levelTF.width / 2 + 3;
         if(_isWebSelected)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_fbIcon,_progressBG,28,26);
            MobileAlignmentUtil.alignAccordingToPositionOf(_progressCaption,_progressBG,73,35);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_switchProgressChoiceButton,_progressBG,344);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_progressCaption,_progressBG,36);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_switchProgressChoiceButton,_progressBG,-13);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2);
      }
      
      public function swap() : void
      {
         if(_isWebSelected)
         {
            showGuestAccount();
            removeChild(_fbIcon);
         }
         else
         {
            showWebAccount();
            addChild(_fbIcon);
         }
         drawLayout();
      }
      
      private function showWebAccount() : void
      {
         _isWebSelected = true;
         _recommendationTF.textRendererProperties.textFormat = getWomTextFormat(21,"left",6919761);
         var _temp_2:* = _recommendationTF;
         var _loc1_:String = "m.ui.popups.facebookProgress.recommended";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _progressCaption.textRendererProperties.textFormat = getCaptionTextFormat(30,"left",16777215);
         var _temp_3:* = _progressCaption;
         var _loc2_:String = "m.ui.popups.facebookProgress.fbProgress";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _switchProgressChoiceButton.scaleX = 1;
         _fbIcon = assetRepository.getDisplayObject("IconFacebook");
         _levelTF.text = _webLevel;
      }
      
      private function showGuestAccount() : void
      {
         _isWebSelected = false;
         _recommendationTF.textRendererProperties.textFormat = getWomTextFormat(21,"left",15682332);
         var _temp_2:* = _recommendationTF;
         var _loc1_:String = "m.ui.popups.facebookProgress.unrecommended";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _progressCaption.textRendererProperties.textFormat = getCaptionTextFormat(30,"left",16777215);
         var _temp_3:* = _progressCaption;
         var _loc2_:String = "m.ui.popups.facebookProgress.mobileProgress";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _switchProgressChoiceButton.scaleX = -1;
         _levelTF.text = _mobileLevel;
      }
      
      public function get isWebSelected() : Boolean
      {
         return _isWebSelected;
      }
      
      public function get switchProgressChoiceButton() : MPRigidButton
      {
         return _switchProgressChoiceButton;
      }
      
      public function get webLevel() : String
      {
         return _webLevel;
      }
      
      public function get mobileLevel() : String
      {
         return _mobileLevel;
      }
   }
}

