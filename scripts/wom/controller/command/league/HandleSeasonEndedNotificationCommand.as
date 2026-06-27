package wom.controller.command.league
{
   import starling.display.DisplayObject;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.message.notification.league.SeasonEndedNotification;
   import wom.view.screen.popups.league.MobileLeagueSeasonEndedPopUp;
   import wom.view.screen.popups.league.MobileLeagueSeasonEndedSuccessPopUp;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   
   public class HandleSeasonEndedNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleSeasonEndedNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:Boolean = false;
         var _loc1_:DisplayObject = null;
         var _loc2_:SeasonEndedNotification = messageReceivedEvent.message as SeasonEndedNotification;
         leagueManager.myLeague = null;
         dispatch(new ModelUpdateEvent("leagueStatusUpdated"));
         var _loc3_:Object = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
         if(_loc2_.position >= 1 && _loc2_.position <= 3 && !isNaN(_loc2_.reward))
         {
            _loc1_ = new MobileLeagueSeasonEndedSuccessPopUp(_loc2_.leagueLevelId,_loc2_.position,_loc2_.seasonEndTime,int(_loc2_.reward * _loc2_.ratio),_loc2_.rpReward);
         }
         else
         {
            _loc1_ = new MobileLeagueSeasonEndedPopUp(_loc2_.leagueLevelId,_loc2_.position,_loc2_.seasonEndTime);
         }
         _loc4_ = _loc3_ != null && _loc3_ is MobileLeaderboardWindow;
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",_loc1_,_loc4_ ? 0 : null));
      }
   }
}

