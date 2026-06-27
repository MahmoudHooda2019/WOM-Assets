package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class TournamentAttackRemainingDurChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingDuration:int;
      
      public function TournamentAttackRemainingDurChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingDuration = param1.remainingDuration;
      }
      
      public function get remainingDuration() : int
      {
         return _remainingDuration;
      }
   }
}

