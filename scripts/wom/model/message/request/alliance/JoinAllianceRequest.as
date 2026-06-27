package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class JoinAllianceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _allianceId:Number;
      
      public function JoinAllianceRequest(param1:Number)
      {
         super();
         _allianceId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"allianceId":_allianceId};
      }
   }
}

