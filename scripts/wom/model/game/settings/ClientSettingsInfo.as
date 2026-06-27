package wom.model.game.settings
{
   public class ClientSettingsInfo
   {
      
      private var _soundEnabled:Boolean;
      
      private var _musicEnabled:Boolean;
      
      private var _splashEnabled:Boolean;
      
      public function ClientSettingsInfo(param1:Boolean, param2:Boolean, param3:Boolean)
      {
         super();
         _soundEnabled = param1;
         _musicEnabled = param2;
         _splashEnabled = param3;
      }
      
      public function serialize() : Object
      {
         return {
            "soundEnabled":_soundEnabled,
            "musicEnabled":_musicEnabled,
            "splashEnabled":_splashEnabled
         };
      }
      
      public function get soundEnabled() : Boolean
      {
         return _soundEnabled;
      }
      
      public function set soundEnabled(param1:Boolean) : void
      {
         _soundEnabled = param1;
      }
      
      public function get musicEnabled() : Boolean
      {
         return _musicEnabled;
      }
      
      public function set musicEnabled(param1:Boolean) : void
      {
         _musicEnabled = param1;
      }
      
      public function get splashEnabled() : Boolean
      {
         return _splashEnabled;
      }
      
      public function set splashEnabled(param1:Boolean) : void
      {
         _splashEnabled = param1;
      }
   }
}

