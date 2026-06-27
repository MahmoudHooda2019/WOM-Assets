package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class SpyTimeoutEventNotification extends AbstractIncomingMessage
   {
      
      public function SpyTimeoutEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
      }
   }
}

