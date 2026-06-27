package wom.model.message.notification
{
   import flash.utils.ByteArray;
   import peak.messaging.AbstractIncomingMessage;
   import peak.util.Base64;
   
   public class ShowCaptchaEventNotification extends AbstractIncomingMessage
   {
      
      private var _captchaImageByteArray:ByteArray;
      
      private var _captchaWidth:int;
      
      private var _captchaHeight:int;
      
      public function ShowCaptchaEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _captchaImageByteArray = Base64.decodeToByteArray(param1.captcha);
         _captchaWidth = param1.width;
         _captchaHeight = param1.height;
      }
      
      public function get captchaImageByteArray() : ByteArray
      {
         return _captchaImageByteArray;
      }
      
      public function get captchaWidth() : int
      {
         return _captchaWidth;
      }
      
      public function get captchaHeight() : int
      {
         return _captchaHeight;
      }
   }
}

