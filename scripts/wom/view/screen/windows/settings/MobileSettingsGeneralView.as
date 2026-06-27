package wom.view.screen.windows.settings
{
   import peak.component.mobile.MPTextField;
   import peak.component.mobile.MPToggleSwitch;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomToggleSwitch;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileSettingsGeneralView extends Sprite
   {
      
      private static const WIDTH:int = 492;
      
      private static const HEIGHT:int = 416;
      
      private var _isGooglePlusAvailable:Boolean;
      
      private var _googlePlusSignedIn:Boolean;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      public var _background:DisplayObject;
      
      private var _musicTF:MPTextField;
      
      private var _soundTF:MPTextField;
      
      private var _bloodTF:MPTextField;
      
      private var _languageTF:MPTextField;
      
      private var _languageButton:MobileWomButton;
      
      private var _fbConnectButton:MobileWomButton;
      
      private var _googlePlusControllerIcon:DisplayObject;
      
      private var _googlePlusSignInButton:MobileWomButton;
      
      private var _googlePlusAchievementsButton:MobileWomButton;
      
      private var _musicToogle:MPToggleSwitch;
      
      private var _soundToogle:MPToggleSwitch;
      
      private var _bloodToogle:MPToggleSwitch;
      
      private var _connectionBackground:DisplayObject;
      
      private var _connectionTF:MPTextField;
      
      private var _connectionIcon:DisplayObject;
      
      public function MobileSettingsGeneralView(param1:Boolean, param2:MobileWomAssetRepository)
      {
         var _loc3_:DisplayObject = null;
         super();
         _isGooglePlusAvailable = param1;
         _googlePlusSignedIn = false;
         _assetRepository = param2;
         _background = _assetRepository.getDisplayObject("MobileBeigeBackground");
         _background.width = 492;
         _background.height = 416 + (_isGooglePlusAvailable ? 156 : 0);
         addChild(_background);
         _musicTF = createTF("music");
         _musicToogle = new MobileWomToggleSwitch();
         addChild(_musicToogle);
         _soundTF = createTF("soundEffects");
         _soundToogle = new MobileWomToggleSwitch();
         addChild(_soundToogle);
         _bloodTF = createTF("bloodEffects");
         _bloodToogle = new MobileWomToggleSwitch();
         addChild(_bloodToogle);
         _languageTF = createTF("language");
         _languageButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _languageButton.width = 142;
         _languageButton.label = Languages.determineLanguage(Languages.activeLanguageId).fullName;
         addChild(_languageButton);
         _connectionBackground = param2.getDisplayObject("MobileDarkBackground");
         _connectionBackground.height = 99 + (_isGooglePlusAvailable ? 156 : 0);
         _connectionBackground.width = 455;
         addChild(_connectionBackground);
         _connectionIcon = param2.getDisplayObject("SymbolConnected");
         addChild(_connectionIcon);
         _connectionTF = new MobileCaptionTextField();
         _connectionTF.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(_connectionTF);
         var _temp_16:* = _connectionTF;
         var _loc5_:String = "m.ui.windows.settings.connectedInfo";
         _temp_16.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _fbConnectButton = MobileWomUIComponentFactory.createMobileColoredButton("DarkBlue","Medium");
         _fbConnectButton.width = 404;
         var _temp_18:* = _fbConnectButton;
         var _loc6_:String = "m.ui.popups.facebookGetGold.buttonText";
         _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _fbConnectButton.defaultIcon = _assetRepository.getDisplayObject("IconGoldL");
         var _temp_19:* = _fbConnectButton;
         var _loc7_:String = "m.ui.popups.facebookGetGold.goldAmount";
         _temp_19.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_fbConnectButton);
         var _loc4_:DisplayObject = _assetRepository.getDisplayObject("IconFacebookW");
         _fbConnectButton.addChild(_loc4_);
         _loc4_.x = 10;
         _loc4_.y = 13;
         if(_isGooglePlusAvailable)
         {
            _googlePlusControllerIcon = _assetRepository.getDisplayObject("IconGooglePlusController");
            addChild(_googlePlusControllerIcon);
            _googlePlusAchievementsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
            _googlePlusAchievementsButton.width = 309;
            var _temp_22:* = _googlePlusAchievementsButton;
            var _loc8_:String = "ui.achievements.title";
            _temp_22.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            _googlePlusAchievementsButton.labelOffsetX = 20;
            _googlePlusAchievementsButton.isEnabled = false;
            addChild(_googlePlusAchievementsButton);
            _loc3_ = _assetRepository.getDisplayObject("IconGooglePlusAchievements");
            _googlePlusAchievementsButton.addChild(_loc3_);
            _loc3_.x = 10;
            _loc3_.y = 13;
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_musicTF,_background,100,33);
         MobileAlignmentUtil.alignAccordingToPositionOf(_musicToogle,_musicTF,159,-5);
         MobileAlignmentUtil.alignAccordingToPositionOf(_soundTF,_musicTF,0,61);
         MobileAlignmentUtil.alignAccordingToPositionOf(_soundToogle,_soundTF,159,-5);
         MobileAlignmentUtil.alignAccordingToPositionOf(_bloodTF,_soundTF,0,61);
         MobileAlignmentUtil.alignAccordingToPositionOf(_bloodToogle,_bloodTF,159,-5);
         MobileAlignmentUtil.alignAccordingToPositionOf(_languageTF,_bloodTF,0,70);
         MobileAlignmentUtil.alignAccordingToPositionOf(_languageButton,_languageTF,155,-20);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_connectionBackground,_background,282);
         if(_isGooglePlusAvailable)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_fbConnectButton,_connectionBackground,18);
            MobileAlignmentUtil.alignAccordingToPositionOf(_googlePlusControllerIcon,_connectionBackground,25,134);
            if(_googlePlusSignInButton)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_googlePlusSignInButton,_connectionBackground,120,96);
            }
            MobileAlignmentUtil.alignAccordingToPositionOf(_googlePlusAchievementsButton,_connectionBackground,120,174);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleOf(_fbConnectButton,_connectionBackground);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_connectionIcon,_connectionBackground,68,36);
         MobileAlignmentUtil.alignAccordingToPositionOf(_connectionTF,_connectionBackground,99,39);
      }
      
      private function createTF(param1:String, param2:int = 0) : MPTextField
      {
         var _loc3_:MPTextField = new MobileWomTextField();
         _loc3_.textRendererProperties.textFormat = getWomTextFormat(25,"left",param2);
         addChild(_loc3_);
         var _temp_1:* = _loc3_;
         var _loc4_:String = "m.ui.windows.settings." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         return _loc3_;
      }
      
      public function resetConnectionView(param1:Boolean) : void
      {
         if(!param1)
         {
            if(!_fbConnectButton.visible)
            {
               _fbConnectButton.visible = true;
               _connectionIcon.visible = false;
               _connectionTF.visible = false;
            }
         }
         else
         {
            _fbConnectButton.visible = false;
            _connectionIcon.visible = true;
            _connectionTF.visible = true;
         }
         drawLayout();
      }
      
      public function checkGooglePlusSignIn(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         if((_googlePlusSignedIn && !param1 || !_googlePlusSignedIn && param1) && _googlePlusSignInButton && contains(_googlePlusSignInButton))
         {
            removeChild(_googlePlusSignInButton);
            _googlePlusSignInButton = null;
         }
         if(!_googlePlusSignInButton)
         {
            _googlePlusSignInButton = MobileWomUIComponentFactory.createMobileColoredButton(param1 ? "Red" : "Yellow","Medium");
            _googlePlusSignInButton.width = 309;
            var _temp_8:* = _googlePlusSignInButton;
            var _loc3_:String = param1 ? "m.ui.windows.settings.disconnect" : "m.ui.windows.settings.googlePlusConnect";
            _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _googlePlusSignInButton.labelOffsetX = 20;
            addChild(_googlePlusSignInButton);
            _loc2_ = _assetRepository.getDisplayObject("IconGooglePlus");
            _googlePlusSignInButton.addChild(_loc2_);
            _loc2_.x = 10;
            _loc2_.y = 13;
         }
         _googlePlusAchievementsButton.isEnabled = param1;
         _googlePlusSignedIn = param1;
         drawLayout();
      }
      
      public function get languageButton() : MobileWomButton
      {
         return _languageButton;
      }
      
      public function get fbConnectButton() : MobileWomButton
      {
         return _fbConnectButton;
      }
      
      public function get isGooglePlusAvailable() : Boolean
      {
         return _isGooglePlusAvailable;
      }
      
      public function get googlePlusSignInButton() : MobileWomButton
      {
         return _googlePlusSignInButton;
      }
      
      public function get googlePlusAchievementsButton() : MobileWomButton
      {
         return _googlePlusAchievementsButton;
      }
      
      public function get musicToogle() : MPToggleSwitch
      {
         return _musicToogle;
      }
      
      public function get soundToogle() : MPToggleSwitch
      {
         return _soundToogle;
      }
      
      public function get bloodToogle() : MPToggleSwitch
      {
         return _bloodToogle;
      }
   }
}

