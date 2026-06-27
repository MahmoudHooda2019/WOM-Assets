package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class HealBeastRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function HealBeastRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

