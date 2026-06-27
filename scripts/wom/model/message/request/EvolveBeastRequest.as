package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class EvolveBeastRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function EvolveBeastRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

