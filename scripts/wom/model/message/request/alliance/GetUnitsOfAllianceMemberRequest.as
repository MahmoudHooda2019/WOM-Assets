package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetUnitsOfAllianceMemberRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _memberId:String;
      
      public function GetUnitsOfAllianceMemberRequest(param1:String)
      {
         super();
         _memberId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"memberId":_memberId};
      }
   }
}

