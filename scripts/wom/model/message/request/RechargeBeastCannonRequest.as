package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RechargeBeastCannonRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function RechargeBeastCannonRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

