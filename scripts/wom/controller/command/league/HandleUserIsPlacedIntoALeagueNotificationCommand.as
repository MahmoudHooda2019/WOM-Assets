package wom.controller.command.league
{
   import starling.display.DisplayObject;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.UserInfo;
   import wom.model.game.league.LeagueInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.league.LeagueSeasonInfo;
   import wom.model.message.notification.league.UserIsPlacedIntoALeagueNotification;
   import wom.view.screen.popups.league.MobileLeagueStatusChangedPopUp;
   import wom.view.screen.popups.league.MobileLeagueStatusPlacedPopUp;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   
   public class HandleUserIsPlacedIntoALeagueNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUserIsPlacedIntoALeagueNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc1_:DisplayObject = null;
         var _loc3_:UserIsPlacedIntoALeagueNotification = messageReceivedEvent.message as UserIsPlacedIntoALeagueNotification;
         var _loc2_:LeagueLevelDIO = domainInfo.getLeagueLevel(_loc3_.leagueLevelId);
         if(_loc2_ != null)
         {
            leagueManager.myLeague = new LeagueInfo(new LeagueSeasonInfo(_loc3_.remainingDuration),_loc2_,_loc3_.rpReward,_loc3_.ratio);
            dispatch(new ModelUpdateEvent("leagueStatusUpdated"));
            _loc4_ = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
            _loc1_ = _loc3_.firstTime ? new MobileLeagueStatusPlacedPopUp(_loc2_) : new MobileLeagueStatusChangedPopUp(_loc2_);
            _loc4_ = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
            _loc5_ = _loc4_ != null && _loc4_ is MobileLeaderboardWindow;
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",_loc1_,_loc5_ ? 0 : null));
         }
      }
   }
}

