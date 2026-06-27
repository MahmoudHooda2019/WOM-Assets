package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class DelayNPCAttackRequest extends AbstractOutgoingMessage
   {
      
      public function DelayNPCAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

