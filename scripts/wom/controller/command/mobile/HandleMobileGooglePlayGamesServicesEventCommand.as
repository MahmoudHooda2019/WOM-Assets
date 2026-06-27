package wom.controller.command.mobile
{
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileGooglePlayGamesServicesEvent;
   import wom.service.mobile.MobileGooglePlayGamesServicesManager;
   
   public class HandleMobileGooglePlayGamesServicesEventCommand extends PCommand
   {
      
      [Inject]
      public var event:MobileGooglePlayGamesServicesEvent;
      
      [Inject]
      public var googlePlayGamesServicesManager:MobileGooglePlayGamesServicesManager;
      
      public function HandleMobileGooglePlayGamesServicesEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         switch(event.type)
         {
            case "initGooglePlayGamesServices":
               googlePlayGamesServicesManager.init();
               break;
            case "signInGooglePlayGamesServices":
               googlePlayGamesServicesManager.signIn();
               break;
            case "signOutGooglePlayGamesServices":
               googlePlayGamesServicesManager.signOut();
               break;
            case "showStandardAchievements":
               googlePlayGamesServicesManager.showStandardAchievements();
               break;
            case "googlePlayGamesServicesStatusUpdated":
               googlePlayGamesServicesManager.checkCompletedAchievements();
         }
      }
   }
}

