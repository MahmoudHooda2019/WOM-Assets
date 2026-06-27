package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class UserStatusRequest extends AbstractOutgoingMessage
   {
      
      public function UserStatusRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

