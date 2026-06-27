package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetCityPlansRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetCityPlansRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

