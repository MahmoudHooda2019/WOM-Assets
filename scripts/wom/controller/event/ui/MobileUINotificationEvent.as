package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class MobileUINotificationEvent extends Event
   {
      
      public static const SHOW:String = "mobileUINotificationEventShow";
      
      private var _message:String;
      
      private var _delay:Number;
      
      public function MobileUINotificationEvent(param1:String, param2:String, param3:Number = 2)
      {
         super(param1);
         _message = param2;
         _delay = param3;
      }
      
      override public function clone() : Event
      {
         return new MobileUINotificationEvent(type,_message,_delay);
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
   }
}

