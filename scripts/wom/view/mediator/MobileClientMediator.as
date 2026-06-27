package wom.view.mediator
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.MobileClient;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.mobile.MobileGooglePlayGamesServicesEvent;
   import wom.model.game.WomScreenType;
   import wom.service.RetrieveDevelopersService;
   import wom.service.mobile.MobileConnectionService;
   import wom.service.mobile.MobileGooglePlayGamesServicesManager;
   
   public class MobileClientMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileClient;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var mobileConnectionService:MobileConnectionService;
      
      [Inject]
      public var retrieveDevelopersService:RetrieveDevelopersService;
      
      [Inject]
      public var googlePlayGamesServicesManager:MobileGooglePlayGamesServicesManager;
      
      public function MobileClientMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         trace("MobileStarlingClientMediator.onRegister()");
         addContextListener("activateLoginScreen",onLoginScreenActivated);
         addContextListener("deactivateLoginScreen",onLoginScreenDeactivated);
         addContextListener("restartMobileApplication",onRestart);
         mobileConnectionService.handleStartupConnection();
         dispatch(new MobileGooglePlayGamesServicesEvent("initGooglePlayGamesServices"));
      }
      
      private function onRestart(param1:flash.events.Event) : void
      {
         view.restart();
      }
      
      override public function onRemove() : void
      {
         trace("MobileStarlingClientMediator.onRemove()");
      }
      
      private function onLoginScreenActivated(param1:flash.events.Event) : void
      {
         injector.injectInto(view);
         view.initLoginButtons();
         eventMap.mapStarlingListener(view.facebookButton,"triggered",onConnectFBButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.guestButton,"triggered",onPlayAsGuestButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.developersButton,"triggered",onRetrieveDevelopersButtonClicked,starling.events.Event);
         addContextListener("googlePlayGamesServicesStatusUpdated",onGooglePlayGamesServicesStatusUpdated,MobileGooglePlayGamesServicesEvent);
      }
      
      private function removeLoginStage() : void
      {
         view.removeLoginStage();
         removeContextListener("googlePlayGamesServicesStatusUpdated",onGooglePlayGamesServicesStatusUpdated,MobileGooglePlayGamesServicesEvent);
      }
      
      private function onLoginScreenDeactivated(param1:flash.events.Event) : void
      {
         removeLoginStage();
      }
      
      private function onPlayAsGuestButtonClicked(param1:starling.events.Event) : void
      {
         mobileConnectionService.loginAsGuest();
      }
      
      private function onConnectFBButtonClicked(param1:starling.events.Event) : void
      {
         mobileConnectionService.loginWithFacebook();
      }
      
      private function onRetrieveDevelopersButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:* = null;
      }
      
      private function googlePlayGamesServicesStatusUpdated() : void
      {
         if(view.googlePlusSignInAsset)
         {
            eventMap.unmapStarlingListener(view.googlePlusSignInAsset,"touch",onGooglePlusSignInAssetClicked,TouchEvent);
         }
         var _loc1_:Boolean = googlePlayGamesServicesManager.isSupported();
         var _loc2_:Boolean = _loc1_ && googlePlayGamesServicesManager.isSignedIn();
         view.updateGooglePlusSignIn(_loc1_,_loc2_);
         if(view.googlePlusSignInAsset)
         {
            eventMap.mapStarlingListener(view.googlePlusSignInAsset,"touch",onGooglePlusSignInAssetClicked,TouchEvent);
         }
         if(_loc2_)
         {
            view.updateLoginButtonsAccordingToGooglePlusSignIn();
         }
      }
      
      private function onGooglePlayGamesServicesStatusUpdated(param1:MobileGooglePlayGamesServicesEvent) : void
      {
         googlePlayGamesServicesStatusUpdated();
      }
      
      private function onGooglePlusSignInAssetClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.googlePlusSignInAsset,"ended");
         if(_loc2_)
         {
            dispatch(new MobileGooglePlayGamesServicesEvent("signInGooglePlayGamesServices"));
         }
      }
   }
}

