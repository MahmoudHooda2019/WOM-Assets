package wom.controller.command.ui
{
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.resource.SoundPlayer;
   import peak.serialization.json.PJSON;
   import peak.util.FullScreenExitUtil;
   import wom.Environment;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.SettingsEvent;
   import wom.model.component.CoreManager;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.settings.ClientSettingType;
   
   public class MobileApplySettingsCommand extends StarlingCommand
   {
      
      [Inject]
      public var event:SettingsEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileApplySettingsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         switch(event.settingType)
         {
            case ClientSettingType.ZOOM:
               applyZoomSetting();
               break;
            case ClientSettingType.FULL_SCREEN:
               applyFullScreenSetting();
               break;
            case ClientSettingType.SOUND:
               applySoundSetting();
               break;
            case ClientSettingType.MUSIC:
               applyMusicSetting(true);
               break;
            case ClientSettingType.SPLASH:
               applySplashSetting();
               break;
            case ClientSettingType.ALL:
               applySoundSetting();
               applyMusicSetting();
               applySplashSetting();
         }
         if(event.settingType.persisted)
         {
            dispatch(new MobileExternalInterfaceEvent("updateClientSettings",PJSON.encode(documentConfiguration.settings)));
         }
      }
      
      private function applyFullScreenSetting() : void
      {
         var _loc1_:String = Environment.stage.displayState;
         if(event.settingValue != null)
         {
            Environment.stage.displayState = "normal";
         }
         else if(Environment.stage.displayState != "normal")
         {
            Environment.stage.displayState = "normal";
         }
         else if(contextView.stage.hasOwnProperty("allowsFullScreen") && contextView.stage["allowsFullScreen"] === true)
         {
            Environment.stage.focus = Environment.stage;
            FullScreenExitUtil.fullScreenRequestWhileFocused = true;
            Environment.stage.displayState = "fullScreen";
         }
      }
      
      private function applySoundSetting() : void
      {
         var _loc1_:Boolean = Boolean(event.settingValue != null ? event.settingValue : documentConfiguration.settings.soundEnabled);
         documentConfiguration.settings.soundEnabled = _loc1_;
         soundPlayer.sfxEnabled = _loc1_;
      }
      
      private function applyMusicSetting(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = Boolean(event.settingValue != null ? event.settingValue : documentConfiguration.settings.musicEnabled);
         documentConfiguration.settings.musicEnabled = _loc2_;
         soundPlayer.musicEnabled = _loc2_;
      }
      
      private function applySplashSetting() : void
      {
         var _loc1_:Boolean = Boolean(event.settingValue != null ? event.settingValue : documentConfiguration.settings.splashEnabled);
         documentConfiguration.settings.splashEnabled = _loc1_;
         coreManager.changeBloodEffectSetting(_loc1_);
      }
      
      private function applyZoomSetting() : void
      {
         var _loc1_:Boolean = Boolean(event.settingValue);
         _loc1_ ? coreManager.zoomIn() : coreManager.zoomOut();
      }
   }
}

