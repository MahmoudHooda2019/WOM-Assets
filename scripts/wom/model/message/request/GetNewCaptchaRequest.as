package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetNewCaptchaRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function GetNewCaptchaRequest()
      {
         super();
      }
      
      override public function serialize() : Object
      {
         return null;
      }
   }
}

