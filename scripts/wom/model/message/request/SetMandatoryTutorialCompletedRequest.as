package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SetMandatoryTutorialCompletedRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function SetMandatoryTutorialCompletedRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

