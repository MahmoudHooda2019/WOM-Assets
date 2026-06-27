package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetMapInfoRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetMapInfoRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

