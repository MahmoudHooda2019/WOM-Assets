package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class PrepareNPCAttackRequest extends AbstractOutgoingMessage
   {
      
      public function PrepareNPCAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

