package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileGooglePlayGamesServicesEvent extends Event
   {
      
      public static const INIT:String = "initGooglePlayGamesServices";
      
      public static const SIGN_IN:String = "signInGooglePlayGamesServices";
      
      public static const SIGN_OUT:String = "signOutGooglePlayGamesServices";
      
      public static const SHOW_STANDARD_ACHIEVEMENTS:String = "showStandardAchievements";
      
      public static const STATUS_UPDATED:String = "googlePlayGamesServicesStatusUpdated";
      
      public function MobileGooglePlayGamesServicesEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new MobileGooglePlayGamesServicesEvent(type);
      }
   }
}

