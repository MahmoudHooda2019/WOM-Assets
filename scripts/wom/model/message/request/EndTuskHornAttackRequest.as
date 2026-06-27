package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class EndTuskHornAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function EndTuskHornAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

