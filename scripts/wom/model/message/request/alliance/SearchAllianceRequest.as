package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SearchAllianceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _allianceName:String;
      
      public function SearchAllianceRequest(param1:String)
      {
         super();
         _allianceName = param1;
      }
      
      override public function serialize() : Object
      {
         return {"name":_allianceName};
      }
   }
}

