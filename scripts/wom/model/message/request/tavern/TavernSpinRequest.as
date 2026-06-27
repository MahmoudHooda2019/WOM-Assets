package wom.model.message.request.tavern
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class TavernSpinRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function TavernSpinRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

