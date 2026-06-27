package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.settings.ClientSettingType;
   
   public class SettingsEvent extends Event
   {
      
      public static const APPLY_SETTINGS:String = "applySettings";
      
      private var _settingType:ClientSettingType;
      
      private var _settingValue:Object;
      
      public function SettingsEvent(param1:String, param2:ClientSettingType, param3:Object)
      {
         super(param1);
         _settingType = param2;
         _settingValue = param3;
      }
      
      override public function clone() : Event
      {
         return new SettingsEvent(type,_settingType,_settingValue);
      }
      
      public function get settingType() : ClientSettingType
      {
         return _settingType;
      }
      
      public function get settingValue() : Object
      {
         return _settingValue;
      }
   }
}

