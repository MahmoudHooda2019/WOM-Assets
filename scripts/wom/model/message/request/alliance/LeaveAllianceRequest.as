package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class LeaveAllianceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function LeaveAllianceRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

