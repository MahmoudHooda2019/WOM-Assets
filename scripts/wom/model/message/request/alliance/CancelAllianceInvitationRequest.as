package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class CancelAllianceInvitationRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _userId:String;
      
      public function CancelAllianceInvitationRequest(param1:String)
      {
         super();
         _userId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"userId":_userId};
      }
   }
}

