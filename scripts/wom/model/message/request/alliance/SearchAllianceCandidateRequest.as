package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SearchAllianceCandidateRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _guid:String;
      
      public function SearchAllianceCandidateRequest(param1:String)
      {
         super();
         _guid = param1;
      }
      
      override public function serialize() : Object
      {
         return {"guid":_guid};
      }
   }
}

