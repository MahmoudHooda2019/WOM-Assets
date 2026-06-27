package wom.controller.event
{
   import flash.events.Event;
   
   public class MessageDisplayEvent extends Event
   {
      
      public static const MESSAGE_DISPLAY:String = "messageDisplay";
      
      private var _message:String;
      
      public function MessageDisplayEvent(param1:String, param2:String)
      {
         super(param1);
         _message = param2;
      }
      
      override public function clone() : Event
      {
         return new MessageDisplayEvent(type,_message);
      }
      
      public function get message() : String
      {
         return _message;
      }
   }
}

