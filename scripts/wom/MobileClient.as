package wom
{
   import com.freshplanet.ane.AirChartboost;
   import com.freshplanet.ane.AirDeviceId;
   import com.hasoffers.nativeExtensions.MobileAppTracker;
   import flash.desktop.NativeApplication;
   import flash.system.System;
   import flash.utils.getTimer;
   import net.peakgames.ane.kontagent.KontagentController;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.starling.StarlingAssetManager;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.service.mobile.EncryptedLocalStoreUtil;
   import wom.util.HasoffersUtil;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   
   public class MobileClient extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var assetManager:StarlingAssetManager;
      
      private var loadingBackground:Image;
      
      private var loadingTextImage:DisplayObject;
      
      private var scale:int;
      
      private var resolution:String;
      
      private var skipFrame:Boolean;
      
      private var loadedOther:Boolean;
      
      private var _guestButton:MobileWomButton;
      
      private var _facebookButton:MobileWomButton;
      
      private var _developersButton:MobileWomButton;
      
      private var loginScreenInitialized:Boolean;
      
      private var loginScreenRemoved:Boolean;
      
      private var facebookBenefitTextField:MPTextField;
      
      private var facebookBenefitQuadSprite:Sprite;
      
      private var _googlePlusSignInAsset:Sprite;
      
      private var firstTimeLoad:Boolean;
      
      public function MobileClient()
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         super();
         firstTimeLoad = false;
         if(AirDeviceId.getInstance().isOnAndroid)
         {
            KontagentController.apiKey = "ed878148eae4442db500de505efa97bd";
            _loc4_ = "527cfa8516ba47bf50000010";
            _loc2_ = "24d1d373ecf2ff7999d8267c832ae5b8c1664f08";
         }
         else if(AirDeviceId.getInstance().isOnIOS)
         {
            KontagentController.apiKey = "4596961b512b4164836046131ad19028";
            _loc4_ = "527cfbe916ba47bf50000019";
            _loc2_ = "c21f76054e99f317b0dd0995462a22d4d0df03de";
         }
         KontagentController.testMode = false;
         var _loc3_:XML = NativeApplication.nativeApplication.applicationDescriptor;
         var _loc1_:Namespace = _loc3_.namespace();
         KontagentController.appVersion = _loc3_._loc1_::versionLabel;
         AirChartboost.getInstance().startSession(_loc4_,_loc2_);
         addEventListener("addedToStage",onAddedToStage);
         loginScreenInitialized = false;
         loginScreenRemoved = false;
      }
      
      private function initHasoffers() : void
      {
         var _loc1_:MobileAppTracker = null;
         _loc1_ = MobileAppTracker.instance;
         _loc1_.init("2362","03ac19d9aa72f25e00c0f744093ec245");
         _loc1_.trackInstall();
      }
      
      public function initLoginButtons() : void
      {
         loginScreenInitialized = true;
         loadingTextImage.visible = false;
         _guestButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
         _guestButton.width = 220;
         var _temp_3:* = _guestButton;
         var _loc1_:String = "m.ui.loginscreen.guest";
         _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_guestButton);
         _facebookButton = MobileWomUIComponentFactory.createMobileColoredButton("DarkBlue","Large");
         _facebookButton.disableTruncation = true;
         _facebookButton.width = 500;
         addChild(_facebookButton);
         var _temp_5:* = _facebookButton;
         var _loc2_:String = "m.ui.loginscreen.fbconnect";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _developersButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _developersButton.width = 250;
         _developersButton.label = "LOGIN AS...";
         _developersButton.isEnabled = _developersButton.visible = false;
         addChild(_developersButton);
         facebookBenefitTextField = new MobileWomTextField();
         facebookBenefitTextField.textRendererProperties.textFormat = getWomTextFormat(27,"center",16777215);
         addChild(facebookBenefitTextField);
         var _temp_8:* = facebookBenefitTextField;
         var _loc3_:String = "m.ui.loginscreen.fbbenefit";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         initQuadSprite(facebookBenefitTextField.width,facebookBenefitTextField.height);
         drawLayout();
      }
      
      private function initQuadSprite(param1:Number, param2:Number) : void
      {
         facebookBenefitQuadSprite = new Sprite();
         addChildAt(facebookBenefitQuadSprite,getChildIndex(facebookBenefitTextField) - 1);
         var _loc5_:Number = 0.6;
         var _loc4_:Quad = new Quad(param1 + 2,param2 / 2,0);
         _loc4_.setVertexAlpha(0,0);
         _loc4_.setVertexAlpha(1,0);
         _loc4_.setVertexAlpha(2,_loc5_);
         _loc4_.setVertexAlpha(3,_loc5_);
         facebookBenefitQuadSprite.addChild(_loc4_);
         var _loc3_:Quad = new Quad(param1 + 2,param2 / 2,0);
         _loc3_.setVertexAlpha(0,_loc5_);
         _loc3_.setVertexAlpha(1,_loc5_);
         _loc3_.setVertexAlpha(2,0);
         _loc3_.setVertexAlpha(3,0);
         facebookBenefitQuadSprite.addChild(_loc3_);
         MobileAlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,0,_loc4_.height);
      }
      
      private function drawLayout() : void
      {
         _facebookButton.x = (stage.stageWidth - _facebookButton.width) / 2;
         _facebookButton.y = stage.stageHeight - 188;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(facebookBenefitTextField,_facebookButton,_facebookButton.height + 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(facebookBenefitQuadSprite,facebookBenefitTextField,1,0);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_guestButton,_facebookButton,_facebookButton.height + 30);
         if(_googlePlusSignInAsset)
         {
            _googlePlusSignInAsset.x = stage.stageWidth - _googlePlusSignInAsset.width - 15;
            _googlePlusSignInAsset.y = 15;
         }
         _developersButton.x = stage.stageWidth - _developersButton.width - 15;
         _developersButton.y = 15 + (_googlePlusSignInAsset ? _googlePlusSignInAsset.height + 15 : 0);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         start();
      }
      
      private function start() : void
      {
         initHasoffers();
         if(EncryptedLocalStoreUtil.getLocalData("Peak-First-Time-Load") == null)
         {
            firstTimeLoad = true;
            EncryptedLocalStoreUtil.setLocalData("Peak-First-Time-Load","true");
            HasoffersUtil.trackAction("849494050");
            KontagentController.getInstance().sendEvent("InitialScreen",{"st1":"FirstFlashLoadStarted"});
         }
         KontagentController.getInstance().sendEvent("InitialScreen",{"st1":"FlashLoadStarted"});
         trace("MOBILECLIENT",getTimer() - Environment.startTime);
         skipFrame = true;
         loadedOther = false;
         scale = Environment.hiRes ? 2 : 1;
         resolution = Environment.hiRes ? "hd" : "sd";
         assetManager = Environment.starlingAssetManager;
         assetManager.enqueuePath("assets/essential/" + resolution,scale);
         assetManager.addEventListener("complete",onEssentialsComplete);
         assetManager.loadQueue();
      }
      
      public function restart() : void
      {
         Environment.gpu.context3D.dispose(true);
      }
      
      private function onEssentialsComplete(param1:Event) : void
      {
         assetManager.removeEventListener("complete",onEssentialsComplete);
         trace("LOADED ESSENTIALS",getTimer() - Environment.startTime);
         loadingBackground = new Image(assetManager.getTexture("LoadingBackground"));
         loadingBackground.scaleX = loadingBackground.scaleY = stage.stageWidth / loadingBackground.width;
         loadingBackground.y = stage.stageHeight - loadingBackground.height;
         loadingTextImage = new Image(assetManager.getTexture("LoadingText"));
         loadingTextImage.x = (stage.stageWidth - loadingTextImage.width) / 2;
         loadingTextImage.y = stage.stageHeight - 143;
         stage.addChildAt(loadingBackground,0);
         stage.addChildAt(loadingTextImage,1);
         addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onLoadingProgress(param1:Number) : void
      {
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(skipFrame)
         {
            skipFrame = false;
            return;
         }
         removeEventListener("enterFrame",onEnterFrame);
         assetManager.enqueuePath("assets/ui/" + resolution,scale);
         assetManager.loadQueue(onLoadingProgress);
         trace("LOADED UI ASSETS",getTimer() - Environment.startTime);
         addEventListener("enterFrame",onEnterFrame2);
      }
      
      private function onEnterFrame2(param1:Event) : void
      {
         removeEventListener("enterFrame",onEnterFrame2);
         assetManager.enqueuePath("assets/canvas",1);
         assetManager.enqueuePath("assets/" + resolution,scale);
         assetManager.addEventListener("complete",onExtrasComplete);
         assetManager.loadQueue(onLoadingProgress);
         Environment.starlingContext = new MobileClientContext(this);
         trace("INITIALIZED ROBOTLEGS",getTimer() - Environment.startTime);
         checkAllLoaded();
      }
      
      private function onExtrasComplete(param1:Event) : void
      {
         assetManager.removeEventListener("complete",onExtrasComplete);
         trace("LOADED ALL ASSETS",getTimer() - Environment.startTime);
         KontagentController.getInstance().sendEvent("InitialScreen",{"st1":"FlashLoadEnded"});
         if(firstTimeLoad)
         {
            HasoffersUtil.trackAction("849494154");
            KontagentController.getInstance().sendEvent("InitialScreen",{"st1":"FirstFlashLoadEnded"});
         }
         checkAllLoaded();
      }
      
      private function checkAllLoaded() : void
      {
         if(loadedOther)
         {
            System.pauseForGCIfCollectionImminent(0.1);
         }
         else
         {
            loadedOther = true;
         }
      }
      
      public function get guestButton() : MobileWomButton
      {
         return _guestButton;
      }
      
      public function get facebookButton() : MobileWomButton
      {
         return _facebookButton;
      }
      
      public function get developersButton() : MobileWomButton
      {
         return _developersButton;
      }
      
      public function get googlePlusSignInAsset() : Sprite
      {
         return _googlePlusSignInAsset;
      }
      
      private function clearGooglePlusSignIn() : void
      {
         if(_googlePlusSignInAsset)
         {
            if(contains(_googlePlusSignInAsset))
            {
               removeChild(_googlePlusSignInAsset);
            }
            _googlePlusSignInAsset = null;
         }
      }
      
      public function updateGooglePlusSignIn(param1:Boolean, param2:Boolean) : void
      {
         var _loc5_:Image = null;
         var _loc4_:MPTextField = null;
         var _loc3_:int = 0;
         if(param1)
         {
            clearGooglePlusSignIn();
            if(!loginScreenRemoved)
            {
               if(!param2)
               {
                  _googlePlusSignInAsset = new Sprite();
                  addChild(_googlePlusSignInAsset);
                  _loc5_ = new Image(assetManager.getTexture("GooglePlusSignInBackground"));
                  _googlePlusSignInAsset.addChild(_loc5_);
                  _loc4_ = new MobileWomTextField();
                  _loc4_.textRendererProperties.textFormat = getWomTextFormat(38);
                  _googlePlusSignInAsset.addChild(_loc4_);
                  var _temp_3:* = _loc4_;
                  var _loc6_:String = "m.ui.loginscreen.googleplussignin";
                  _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
                  _loc3_ = 62;
                  MobileAlignmentUtil.alignMiddleYAxisOf(_loc4_,_loc5_);
                  _loc4_.x = _loc3_ + (_loc5_.width - _loc3_ - _loc4_.width >> 1);
               }
               drawLayout();
            }
         }
      }
      
      public function updateLoginButtonsAccordingToGooglePlusSignIn() : void
      {
         var _loc1_:int = 0;
         if(_guestButton && contains(_guestButton))
         {
            _guestButton.width = 100;
            var _temp_2:* = _guestButton;
            var _loc2_:String = "m.ui.loginscreen.skip";
            _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            _loc1_ = 50;
            _guestButton.x = stage.stageWidth - _guestButton.width - _loc1_;
            _guestButton.y = stage.stageHeight - _guestButton.height - _loc1_;
         }
      }
      
      public function removeLoginStage() : void
      {
         loginScreenRemoved = true;
         stage.removeChild(loadingBackground);
         stage.removeChild(loadingTextImage);
         if(loginScreenInitialized)
         {
            removeChild(_developersButton);
            removeChild(_facebookButton);
            removeChild(_guestButton);
            removeChild(facebookBenefitTextField);
            removeChild(facebookBenefitQuadSprite);
         }
         if(_googlePlusSignInAsset && contains(_googlePlusSignInAsset))
         {
            removeChild(_googlePlusSignInAsset);
         }
      }
   }
}

