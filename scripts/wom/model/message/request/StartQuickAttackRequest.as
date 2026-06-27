package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class StartQuickAttackRequest extends AbstractOutgoingMessage
   {
      
      public function StartQuickAttackRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

