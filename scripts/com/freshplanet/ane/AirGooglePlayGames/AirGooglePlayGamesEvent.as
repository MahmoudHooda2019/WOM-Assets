package com.freshplanet.ane.AirGooglePlayGames
{
   import flash.events.Event;
   
   public class AirGooglePlayGamesEvent extends Event
   {
      
      public static const ON_SIGN_IN_SUCCESS:String = "ON_SIGN_IN_SUCCESS";
      
      public static const ON_SIGN_IN_FAIL:String = "ON_SIGN_IN_FAIL";
      
      public static const ON_SIGN_OUT_SUCCESS:String = "ON_SIGN_OUT_SUCCESS";
      
      public static const ON_PLAYER_IMAGE_READY:String = "ON_PLAYER_IMAGE_READY";
      
      public function AirGooglePlayGamesEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

