package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class FreezeBeastRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function FreezeBeastRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

