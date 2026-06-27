package wom.controller.event
{
   import flash.events.Event;
   import peak.messaging.OutgoingMessage;
   
   public class OutgoingMessageEvent extends Event
   {
      
      public static const OUTGOING_MESSAGE:String = "outgoingMessage";
      
      public static const OUTGOING_CHAT_MESSAGE:String = "outgoingChatMessage";
      
      private var _message:OutgoingMessage;
      
      public function OutgoingMessageEvent(param1:String, param2:OutgoingMessage = null)
      {
         super(param1);
         _message = param2;
      }
      
      public function get message() : OutgoingMessage
      {
         return _message;
      }
      
      override public function clone() : Event
      {
         return new OutgoingMessageEvent(type,message);
      }
   }
}

