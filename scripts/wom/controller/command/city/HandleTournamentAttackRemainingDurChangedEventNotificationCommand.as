package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.TournamentAttackRemainingDurChangedEventNotification;
   
   public class HandleTournamentAttackRemainingDurChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleTournamentAttackRemainingDurChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TournamentAttackRemainingDurChangedEventNotification = messageReceivedEvent.message as TournamentAttackRemainingDurChangedEventNotification;
         userInfo.tournamentNextAttackRemainingDuration = _loc1_.remainingDuration;
      }
   }
}

