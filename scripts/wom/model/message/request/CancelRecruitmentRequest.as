package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class CancelRecruitmentRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function CancelRecruitmentRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return {};
      }
   }
}

