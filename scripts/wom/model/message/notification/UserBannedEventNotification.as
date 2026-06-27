package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UserBannedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingDuration:Number;
      
      public function UserBannedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingDuration = param1.remainingDuration;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
   }
}

