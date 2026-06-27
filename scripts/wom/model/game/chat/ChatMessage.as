package wom.model.game.chat
{
   public class ChatMessage
   {
      
      private var _messageType:ChatMessageType;
      
      private var _senderName:String;
      
      private var _senderPid:String;
      
      private var _chatMessage:String;
      
      private var _messageTime:Date;
      
      private var _fromThisUser:Boolean;
      
      private var _fromAdmin:Boolean;
      
      public function ChatMessage(param1:ChatMessageType, param2:String, param3:String, param4:String, param5:Boolean, param6:Boolean, param7:Date)
      {
         super();
         _messageType = param1;
         _senderPid = param2;
         _senderName = param3;
         _chatMessage = param4;
         _fromThisUser = param5;
         _fromAdmin = param6;
         _messageTime = param7;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get chatMessage() : String
      {
         return _chatMessage;
      }
      
      public function get senderPid() : String
      {
         return _senderPid;
      }
      
      public function get messageTime() : Date
      {
         return _messageTime;
      }
      
      public function get messageType() : ChatMessageType
      {
         return _messageType;
      }
      
      public function get fromThisUser() : Boolean
      {
         return _fromThisUser;
      }
      
      public function get fromAdmin() : Boolean
      {
         return _fromAdmin;
      }
   }
}

