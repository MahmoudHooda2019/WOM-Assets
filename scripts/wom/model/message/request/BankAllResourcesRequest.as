package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BankAllResourcesRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function BankAllResourcesRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

