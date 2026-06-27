package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class TournamentStatusChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingDurationToTournamentStart:Number;
      
      private var _remainingDurationToTournamentEnd:Number;
      
      public function TournamentStatusChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingDurationToTournamentStart = param1.remainingDurationToTournamentStart;
         _remainingDurationToTournamentEnd = param1.remainingDurationToTournamentEnd;
      }
      
      public function get remainingDurationToTournamentStart() : Number
      {
         return _remainingDurationToTournamentStart;
      }
      
      public function get remainingDurationToTournamentEnd() : Number
      {
         return _remainingDurationToTournamentEnd;
      }
   }
}

