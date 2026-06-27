package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.chat.ChatMessage;
   
   public class ChatMessageReceivedEvent extends Event
   {
      
      public static const WORLD_CHAT_MESSAGE_RECEIVED:String = "MESSAGE_RECEIVED";
      
      public static const GLOBAL_CHAT_MESSAGE_ENTERED:String = "globalChatMessageEntered";
      
      public static const ALLIANCE_CHAT_MESSAGE_ENTERED:String = "allianceChatMessageEnter";
      
      public static const ALLIANCE_CHAT_MESSAGE_RECEIVED:String = "allianceChatMessageReceived";
      
      private var _chatMessage:ChatMessage;
      
      public function ChatMessageReceivedEvent(param1:String, param2:ChatMessage)
      {
         super(param1);
         _chatMessage = param2;
      }
      
      override public function clone() : Event
      {
         return new ChatMessageReceivedEvent(type,chatMessage);
      }
      
      public function get chatMessage() : ChatMessage
      {
         return _chatMessage;
      }
   }
}

