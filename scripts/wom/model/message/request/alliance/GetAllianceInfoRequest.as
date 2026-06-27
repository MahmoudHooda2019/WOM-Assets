package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetAllianceInfoRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetAllianceInfoRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

