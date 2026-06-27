package wom.model.message.request.league
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetLeagueMembersRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetLeagueMembersRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

