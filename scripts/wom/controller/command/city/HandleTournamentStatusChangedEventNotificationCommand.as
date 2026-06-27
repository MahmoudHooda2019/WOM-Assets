package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.TournamentStatusChangedEventNotification;
   
   public class HandleTournamentStatusChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleTournamentStatusChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TournamentStatusChangedEventNotification = messageReceivedEvent.message as TournamentStatusChangedEventNotification;
         userInfo.tournamentRemainingDuration = _loc1_.remainingDurationToTournamentEnd;
         userInfo.tournamentStartRemainingDuration = _loc1_.remainingDurationToTournamentStart;
      }
   }
}

