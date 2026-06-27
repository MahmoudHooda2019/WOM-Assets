package com.freshplanet.ane.AirGooglePlayGames
{
   import flash.events.EventDispatcher;
   import flash.events.StatusEvent;
   import flash.external.ExtensionContext;
   import flash.system.Capabilities;
   
   public class AirGooglePlayGames extends EventDispatcher
   {
      
      private static const EXTENSION_ID:String = "com.freshplanet.AirGooglePlayGamesService";
      
      private static var _instance:AirGooglePlayGames;
      
      private var _context:ExtensionContext;
      
      public function AirGooglePlayGames()
      {
         super();
         if(!_instance)
         {
            _context = ExtensionContext.createExtensionContext("com.freshplanet.AirGooglePlayGamesService",null);
            if(!_context)
            {
               throw Error("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
            }
            _context.addEventListener("status",onStatus);
            _instance = this;
            return;
         }
         throw Error("This is a singleton, use getInstance(), do not call the constructor directly.");
      }
      
      public static function get isSupported() : Boolean
      {
         return Capabilities.manufacturer.indexOf("Android") != -1;
      }
      
      public static function getInstance() : AirGooglePlayGames
      {
         return _instance ? _instance : new AirGooglePlayGames();
      }
      
      public function startAtLaunch() : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("startAtLaunch");
         }
      }
      
      public function signIn() : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("signIn");
         }
      }
      
      public function signOut() : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("signOut");
         }
      }
      
      public function reportAchievement(param1:String, param2:Number = 0) : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("reportAchievemnt",param1,param2);
         }
      }
      
      public function reportScore(param1:String, param2:Number) : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("reportScore",param1,param2);
         }
      }
      
      public function showStandardAchievements() : void
      {
         if(AirGooglePlayGames.isSupported)
         {
            _context.call("showStandardAchievements");
         }
      }
      
      public function getActivePlayerName() : String
      {
         var _loc1_:String = null;
         if(AirGooglePlayGames.isSupported)
         {
            _loc1_ = _context.call("getActivePlayerName") as String;
         }
         return _loc1_;
      }
      
      private function onStatus(param1:StatusEvent) : void
      {
         var _loc2_:AirGooglePlayGamesEvent = null;
         trace("[AirGooglePlayGames]",param1);
         if(param1.code == "ON_SIGN_IN_SUCCESS")
         {
            _loc2_ = new AirGooglePlayGamesEvent("ON_SIGN_IN_SUCCESS");
         }
         else if(param1.code == "ON_SIGN_IN_FAIL")
         {
            _loc2_ = new AirGooglePlayGamesEvent("ON_SIGN_IN_FAIL");
         }
         else if(param1.code == "ON_SIGN_OUT_SUCCESS")
         {
            _loc2_ = new AirGooglePlayGamesEvent("ON_SIGN_OUT_SUCCESS");
         }
         if(_loc2_)
         {
            this.dispatchEvent(_loc2_);
         }
      }
   }
}

