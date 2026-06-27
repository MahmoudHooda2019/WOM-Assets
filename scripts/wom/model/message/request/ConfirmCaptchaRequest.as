package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ConfirmCaptchaRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _captchaText:String;
      
      public function ConfirmCaptchaRequest(param1:String)
      {
         super();
         _captchaText = param1;
      }
      
      override public function serialize() : Object
      {
         return {"captchaText":_captchaText};
      }
   }
}

