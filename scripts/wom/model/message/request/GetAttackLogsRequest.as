package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetAttackLogsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetAttackLogsRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

