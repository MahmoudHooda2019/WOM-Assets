package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class VisitCityEndedEventNotification extends AbstractIncomingMessage
   {
      
      public function VisitCityEndedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
      }
   }
}

