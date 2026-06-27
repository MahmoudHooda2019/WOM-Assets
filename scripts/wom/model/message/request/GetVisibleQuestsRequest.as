package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetVisibleQuestsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetVisibleQuestsRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

