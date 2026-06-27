package wom.service.mobile
{
   import com.freshplanet.ane.AirGooglePlayGames.AirGooglePlayGames;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.Actor;
   import wom.controller.event.mobile.MobileGooglePlayGamesServicesEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.game.UserInfo;
   
   public class MobileGooglePlayGamesServicesManager extends Actor
   {
      
      private static const APP_ID:String = "650553791767";
      
      private static var ACHIEVEMENTS:Dictionary = new Dictionary();
      
      ACHIEVEMENTS[1] = "CgkIl6qcwPcSEAIQAQ";
      ACHIEVEMENTS[3] = "CgkIl6qcwPcSEAIQAg";
      ACHIEVEMENTS[4] = "CgkIl6qcwPcSEAIQAw";
      ACHIEVEMENTS[5] = "CgkIl6qcwPcSEAIQBA";
      ACHIEVEMENTS[6] = "CgkIl6qcwPcSEAIQBQ";
      ACHIEVEMENTS[7] = "CgkIl6qcwPcSEAIQBg";
      ACHIEVEMENTS[8] = "CgkIl6qcwPcSEAIQBw";
      ACHIEVEMENTS[9] = "CgkIl6qcwPcSEAIQCA";
      ACHIEVEMENTS[11] = "CgkIl6qcwPcSEAIQCg";
      ACHIEVEMENTS[12] = "CgkIl6qcwPcSEAIQCw";
      ACHIEVEMENTS[13] = "CgkIl6qcwPcSEAIQDA";
      ACHIEVEMENTS[14] = "CgkIl6qcwPcSEAIQDQ";
      ACHIEVEMENTS[15] = "CgkIl6qcwPcSEAIQDg";
      ACHIEVEMENTS[16] = "CgkIl6qcwPcSEAIQDw";
      ACHIEVEMENTS[17] = "CgkIl6qcwPcSEAIQEA";
      ACHIEVEMENTS[18] = "CgkIl6qcwPcSEAIQEQ";
      ACHIEVEMENTS[19] = "CgkIl6qcwPcSEAIQEg";
      ACHIEVEMENTS[20] = "CgkIl6qcwPcSEAIQEw";
      ACHIEVEMENTS[21] = "CgkIl6qcwPcSEAIQFA";
      ACHIEVEMENTS[25] = "CgkIl6qcwPcSEAIQGA";
      ACHIEVEMENTS[26] = "CgkIl6qcwPcSEAIQGQ";
      ACHIEVEMENTS[28] = "CgkIl6qcwPcSEAIQGw";
      ACHIEVEMENTS[29] = "CgkIl6qcwPcSEAIQHA";
      ACHIEVEMENTS[30] = "CgkIl6qcwPcSEAIQHQ";
      ACHIEVEMENTS[35] = "CgkIl6qcwPcSEAIQIg";
      ACHIEVEMENTS[36] = "CgkIl6qcwPcSEAIQIw";
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileGooglePlayGamesServicesManager()
      {
         super();
      }
      
      public function init() : void
      {
         if(isSupported())
         {
            AirGooglePlayGames.getInstance().addEventListener("ON_SIGN_IN_SUCCESS",onSignInSuccess);
            AirGooglePlayGames.getInstance().addEventListener("ON_SIGN_OUT_SUCCESS",onSignOutSuccess);
            AirGooglePlayGames.getInstance().addEventListener("ON_SIGN_IN_FAIL",onSignInFail);
            AirGooglePlayGames.getInstance().startAtLaunch();
            if(isSignedIn())
            {
               signIn();
            }
         }
      }
      
      private function onSignInSuccess(param1:Event) : void
      {
         dispatch(new MobileGooglePlayGamesServicesEvent("googlePlayGamesServicesStatusUpdated"));
      }
      
      private function onSignOutSuccess(param1:Event) : void
      {
         dispatch(new MobileGooglePlayGamesServicesEvent("googlePlayGamesServicesStatusUpdated"));
      }
      
      private function onSignInFail(param1:Event) : void
      {
         dispatch(new MobileGooglePlayGamesServicesEvent("googlePlayGamesServicesStatusUpdated"));
      }
      
      public function showStandardAchievements() : void
      {
         AirGooglePlayGames.getInstance().showStandardAchievements();
      }
      
      public function signIn() : void
      {
         if(isSupported())
         {
            AirGooglePlayGames.getInstance().signIn();
         }
      }
      
      public function signOut() : void
      {
         if(isSupported())
         {
            AirGooglePlayGames.getInstance().signOut();
         }
      }
      
      private function reportAllAchievements() : void
      {
         for(var _loc1_ in userInfo.completedAchievements)
         {
            AirGooglePlayGames.getInstance().reportAchievement(ACHIEVEMENTS[_loc1_]);
         }
      }
      
      public function isSignedIn() : Boolean
      {
         return isSupported() && AirGooglePlayGames.getInstance().getActivePlayerName() != null;
      }
      
      public function isSupported() : Boolean
      {
         return AirGooglePlayGames.isSupported;
      }
      
      public function checkCompletedAchievements() : void
      {
         var _loc3_:Array = null;
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         if(userInfo.profile && isSignedIn())
         {
            reportAllAchievements();
            _loc3_ = userInfo.tutorialsInfo.additionalInfo.completedAchievements;
            _loc1_ = false;
            if(_loc3_.length == 0)
            {
               if(userInfo.completedAchievements)
               {
                  for(_loc2_ in userInfo.completedAchievements)
                  {
                     if(_loc2_ in ACHIEVEMENTS)
                     {
                        _loc3_[_loc2_] = true;
                     }
                  }
               }
               for(_loc2_ in ACHIEVEMENTS)
               {
                  if(!(_loc2_ in userInfo.completedAchievements))
                  {
                     _loc3_[_loc2_] = false;
                  }
               }
               _loc1_ = true;
            }
            else
            {
               for(_loc2_ in ACHIEVEMENTS)
               {
                  if(_loc2_ in userInfo.completedAchievements)
                  {
                     if(!(_loc2_ in _loc3_))
                     {
                        _loc3_[_loc2_] = false;
                     }
                     if(!_loc3_[_loc2_])
                     {
                        _loc3_[_loc2_] = true;
                        _loc1_ = true;
                     }
                  }
               }
            }
            if(_loc1_)
            {
               dispatch(new TutorialEvent("saveTutorialsToServer"));
            }
         }
      }
   }
}

