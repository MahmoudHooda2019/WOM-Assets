package wom.controller.event.ui
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class CaptchaEvent extends Event
   {
      
      public static const SHOW_CAPTCHA_WINDOW:String = "showCaptchaWindow";
      
      public static const CLOSE_CAPTCHA_WINDOW:String = "closeCaptchaWindow";
      
      public static const UPDATE_CAPTCHA:String = "updateCaptcha";
      
      public static const CAPTCHA_RESPONSE_CONFIRMED:String = "captchaResponseConfirmed";
      
      private var _captchaByteArray:ByteArray;
      
      private var _captchaWidth:int;
      
      private var _captchaHeight:int;
      
      public function CaptchaEvent(param1:String, param2:ByteArray = null, param3:int = 0, param4:int = 0)
      {
         super(param1);
         _captchaByteArray = param2;
         _captchaWidth = param3;
         _captchaHeight = param4;
      }
      
      override public function clone() : Event
      {
         return new CaptchaEvent(type,_captchaByteArray,_captchaWidth,_captchaHeight);
      }
      
      public function get captchaByteArray() : ByteArray
      {
         return _captchaByteArray;
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

