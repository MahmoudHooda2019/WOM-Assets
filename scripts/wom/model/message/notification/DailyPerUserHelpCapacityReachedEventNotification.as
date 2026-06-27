package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class DailyPerUserHelpCapacityReachedEventNotification extends AbstractIncomingMessage
   {
      
      public function DailyPerUserHelpCapacityReachedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
      }
   }
}

