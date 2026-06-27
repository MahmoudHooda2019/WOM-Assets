package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class AllBuildingsRepairedEventNotification extends AbstractIncomingMessage
   {
      
      public function AllBuildingsRepairedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
      }
   }
}

