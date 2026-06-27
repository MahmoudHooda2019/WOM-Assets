package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class StartNPCAttackRequest extends AbstractOutgoingMessage
   {
      
      public function StartNPCAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

