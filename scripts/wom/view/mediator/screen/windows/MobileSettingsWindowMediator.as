package wom.view.mediator.screen.windows
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.mobile.MobileGooglePlayGamesServicesEvent;
   import wom.controller.event.ui.SettingsEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.settings.ClientSettingType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.mobile.MobileExternalPages;
   import wom.service.mobile.MobileGooglePlayGamesServicesManager;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.settings.MobileSelectLanguageListItemRenderer;
   import wom.view.screen.windows.settings.MobileSettingsWindow;
   
   public class MobileSettingsWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileSettingsWindow;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      [Inject]
      public var mobileExternalPagesService:MobileExternalPages;
      
      [Inject]
      public var googlePlayGamesServicesManager:MobileGooglePlayGamesServicesManager;
      
      public function MobileSettingsWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.generalView.languageButton,"triggered",onLanguageButtonClicked,Event);
         eventMap.mapStarlingListener(view.generalView.fbConnectButton,"triggered",onFBConnectButtonClicked,Event);
         eventMap.mapStarlingListener(view.helpButton,"triggered",onHelpButtonClicked,Event);
         eventMap.mapStarlingListener(view.generalView.musicToogle,"change",onMusicToggled,Event);
         eventMap.mapStarlingListener(view.generalView.soundToogle,"change",onSoundToggled,Event);
         eventMap.mapStarlingListener(view.generalView.bloodToogle,"change",onBloodToggled,Event);
         addContextListener("googlePlayGamesServicesStatusUpdated",onGooglePlayGamesServicesStatusUpdated,MobileGooglePlayGamesServicesEvent);
         updateWithSettings();
         if(mobileExternalPagesService.externalPages == null)
         {
            dispatch(new MobileExternalInterfaceEvent("getExternalURLs"));
         }
      }
      
      private function onGooglePlayGamesServicesStatusUpdated(param1:MobileGooglePlayGamesServicesEvent) : void
      {
         updateWithSettings();
      }
      
      private function onHelpButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(203,{}));
         view.addWindowEnumeration(new WindowEnumeration(-9,{}));
         closeWindow();
      }
      
      private function checkGooglePlusSignIn() : void
      {
         if(view.generalView.isGooglePlusAvailable)
         {
            if(view.generalView.googlePlusSignInButton)
            {
               eventMap.unmapStarlingListener(view.generalView.googlePlusSignInButton,"triggered",onGooglePlusSignInButtonClicked,Event);
            }
            if(view.generalView.googlePlusAchievementsButton)
            {
               eventMap.unmapStarlingListener(view.generalView.googlePlusAchievementsButton,"triggered",onGooglePlusAchievementsButtonClicked,Event);
            }
            view.generalView.checkGooglePlusSignIn(googlePlayGamesServicesManager.isSignedIn());
            eventMap.mapStarlingListener(view.generalView.googlePlusSignInButton,"triggered",onGooglePlusSignInButtonClicked,Event);
            if(view.generalView.googlePlusAchievementsButton)
            {
               eventMap.mapStarlingListener(view.generalView.googlePlusAchievementsButton,"triggered",onGooglePlusAchievementsButtonClicked,Event);
            }
         }
      }
      
      private function updateWithSettings() : void
      {
         view.generalView.musicToogle.isSelected = documentConfiguration.settings.musicEnabled;
         view.generalView.soundToogle.isSelected = documentConfiguration.settings.soundEnabled;
         view.generalView.bloodToogle.isSelected = documentConfiguration.settings.splashEnabled;
         view.generalView.resetConnectionView(mobileConnectionServiceInfo.isConnectedWithFacebook());
         checkGooglePlusSignIn();
      }
      
      private function onBloodToggled(param1:Event) : void
      {
         var _loc2_:Boolean = view.generalView.bloodToogle.isSelected;
         dispatch(new SettingsEvent("applySettings",ClientSettingType.SPLASH,_loc2_));
         kontagentApi.trackUIEvent("blood_" + (_loc2_ ? "on" : "off"));
      }
      
      private function onSoundToggled(param1:Event) : void
      {
         var _loc2_:Boolean = view.generalView.soundToogle.isSelected;
         dispatch(new SettingsEvent("applySettings",ClientSettingType.SOUND,_loc2_));
         kontagentApi.trackUIEvent("sound_" + (_loc2_ ? "on" : "off"));
      }
      
      private function onMusicToggled(param1:Event) : void
      {
         var _loc2_:Boolean = view.generalView.musicToogle.isSelected;
         dispatch(new SettingsEvent("applySettings",ClientSettingType.MUSIC,_loc2_));
         kontagentApi.trackUIEvent("music_" + (_loc2_ ? "on" : "off"));
      }
      
      private function onFBConnectButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileFacebookConnectionEvent("connectToFacebook"));
      }
      
      private function onGooglePlusSignInButtonClicked(param1:Event) : void
      {
         if(googlePlayGamesServicesManager.isSignedIn())
         {
            dispatch(new MobileGooglePlayGamesServicesEvent("signOutGooglePlayGamesServices"));
         }
         else
         {
            dispatch(new MobileGooglePlayGamesServicesEvent("signInGooglePlayGamesServices"));
         }
      }
      
      private function onGooglePlusAchievementsButtonClicked(param1:Event) : void
      {
         dispatch(new MobileGooglePlayGamesServicesEvent("showStandardAchievements"));
      }
      
      private function onLanguageButtonClicked(param1:Event) : void
      {
         var _loc2_:Boolean = view.selectLangView == null;
         view.toggleView();
         if(_loc2_)
         {
            eventMap.mapStarlingListener(view.selectLangView.backButton,"triggered",onLanguageButtonClicked,Event);
            eventMap.mapStarlingListener(view.selectLangView.languageButtonList,"rendererAdd",onRendererAdded,Event);
            eventMap.mapStarlingListener(view.selectLangView.languageButtonList,"rendererRemove",onRendererRemoved,Event);
         }
      }
      
      private function onRendererAdded(param1:Event, param2:MobileSelectLanguageListItemRenderer) : void
      {
         eventMap.mapStarlingListener(param2.button,"triggered",onChangeLanguageButtonClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileSelectLanguageListItemRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.button,"triggered",onChangeLanguageButtonClicked,Event);
      }
      
      private function onChangeLanguageButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileWomButton = MobileWomButton(param1.target);
         dispatch(new MobileExternalInterfaceEvent("setLanguage",_loc2_.data));
      }
   }
}

