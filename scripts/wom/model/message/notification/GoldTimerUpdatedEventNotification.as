package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class GoldTimerUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingTime:Number;
      
      public function GoldTimerUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingTime = param1.remainingTime;
      }
      
      public function get remainingTime() : Number
      {
         return _remainingTime;
      }
   }
}

