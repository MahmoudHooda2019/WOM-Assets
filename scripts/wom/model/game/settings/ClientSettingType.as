package wom.model.game.settings
{
   public class ClientSettingType
   {
      
      public static const ALL:ClientSettingType = new ClientSettingType(0,false);
      
      public static const FULL_SCREEN:ClientSettingType = new ClientSettingType(1,false);
      
      public static const SOUND:ClientSettingType = new ClientSettingType(2,true);
      
      public static const MUSIC:ClientSettingType = new ClientSettingType(3,true);
      
      public static const SPLASH:ClientSettingType = new ClientSettingType(4,true);
      
      public static const ZOOM:ClientSettingType = new ClientSettingType(5,false);
      
      private var _id:int;
      
      private var _persisted:Boolean;
      
      public function ClientSettingType(param1:int, param2:Boolean)
      {
         super();
         _id = param1;
         _persisted = param2;
      }
      
      public function get persisted() : Boolean
      {
         return _persisted;
      }
   }
}

