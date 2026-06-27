package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SkipNPCAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function SkipNPCAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

