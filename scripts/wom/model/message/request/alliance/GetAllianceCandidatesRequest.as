package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetAllianceCandidatesRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetAllianceCandidatesRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

