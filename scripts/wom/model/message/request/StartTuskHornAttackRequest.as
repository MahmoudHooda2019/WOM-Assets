package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class StartTuskHornAttackRequest extends AbstractOutgoingMessage
   {
      
      public function StartTuskHornAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

