package wom.controller.command.league
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.league.LeagueManager;
   import wom.view.screen.popups.league.MobileLeagueStatusDroppedPopUp;
   import wom.view.screen.windows.rank.LeaderboardWindow;
   
   public class HandleUserIsRemovedFromLeagueNotificationCommand extends PCommand
   {
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUserIsRemovedFromLeagueNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         leagueManager.myLeague = null;
         dispatch(new ModelUpdateEvent("leagueStatusUpdated"));
         var _loc1_:Object = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
         var _loc2_:Boolean = _loc1_ != null && _loc1_ is LeaderboardWindow;
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileLeagueStatusDroppedPopUp(),_loc2_ ? 0 : null));
      }
   }
}

