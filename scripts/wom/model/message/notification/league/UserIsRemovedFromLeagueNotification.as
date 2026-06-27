package wom.model.message.notification.league
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UserIsRemovedFromLeagueNotification extends AbstractIncomingMessage
   {
      
      public function UserIsRemovedFromLeagueNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
      }
   }
}

