package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class StatusRequest extends AbstractOutgoingMessage
   {
      
      public function StatusRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

