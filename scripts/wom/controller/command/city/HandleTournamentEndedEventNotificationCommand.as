package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.TournamentEndedEventNotification;
   import wom.view.screen.popups.tournament.MobileTournamentEndedPopUp;
   
   public class HandleTournamentEndedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleTournamentEndedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TournamentEndedEventNotification = messageReceivedEvent.message as TournamentEndedEventNotification;
         userInfo.tournamentRemainingDuration = 0;
         userInfo.tournamentNextAttackRemainingDuration = 0;
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTournamentEndedPopUp(_loc1_.allianceRanking,_loc1_.endTime,_loc1_.goldReward)));
      }
   }
}

