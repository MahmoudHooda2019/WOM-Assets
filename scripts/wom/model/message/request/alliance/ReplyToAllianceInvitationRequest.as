package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ReplyToAllianceInvitationRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _allianceId:Number;
      
      private var _accepted:Boolean;
      
      public function ReplyToAllianceInvitationRequest(param1:Number, param2:Boolean)
      {
         super();
         _allianceId = param1;
         _accepted = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "allianceId":_allianceId,
            "accepted":_accepted
         };
      }
   }
}

