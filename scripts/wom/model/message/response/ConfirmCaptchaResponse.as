package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ConfirmCaptchaResponse extends AbstractIncomingMessage
   {
      
      private var _captchaCorrect:Boolean;
      
      public function ConfirmCaptchaResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _captchaCorrect = param1.correct;
      }
      
      public function get captchaCorrect() : Boolean
      {
         return _captchaCorrect;
      }
   }
}

