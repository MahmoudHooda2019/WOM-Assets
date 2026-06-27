package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class QuitAllianceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function QuitAllianceRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

