package wom.controller.event
{
   import flash.events.Event;
   import peak.messaging.IncomingMessage;
   
   public class MessageReceivedEvent extends Event
   {
      
      private var _message:IncomingMessage;
      
      private var _messageId:int;
      
      public function MessageReceivedEvent(param1:String, param2:IncomingMessage = null, param3:int = -1)
      {
         super(param1);
         _message = param2;
         _messageId = param3;
      }
      
      public function get message() : IncomingMessage
      {
         return _message;
      }
      
      public function get messageId() : int
      {
         return _messageId;
      }
      
      override public function clone() : Event
      {
         return new MessageReceivedEvent(type,message,messageId);
      }
   }
}

