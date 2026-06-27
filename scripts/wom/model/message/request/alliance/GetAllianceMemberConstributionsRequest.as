package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetAllianceMemberConstributionsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetAllianceMemberConstributionsRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

