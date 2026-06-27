package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ReplyToAllianceJoinRequestRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _userId:String;
      
      private var _accepted:Boolean;
      
      public function ReplyToAllianceJoinRequestRequest(param1:String, param2:Boolean)
      {
         super();
         _userId = param1;
         _accepted = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "userId":_userId,
            "accepted":_accepted
         };
      }
   }
}

