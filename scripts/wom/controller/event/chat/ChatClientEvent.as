package wom.controller.event.chat
{
   import flash.events.Event;
   
   public class ChatClientEvent extends Event
   {
      
      public static const CHAT_CONNECTION_ESTABLISHED:String = "chatConnectionEstablished";
      
      public static const CONNECT_TO_CHAT_SERVER:String = "connectToChatServer";
      
      public static const CHAT_CONNECTION_LOST:String = "chatConnectionLost";
      
      public static const USER_BANNED:String = "userBanned";
      
      private var _data:*;
      
      public function ChatClientEvent(param1:String, param2:* = null)
      {
         super(param1);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new ChatClientEvent(type,data);
      }
   }
}

