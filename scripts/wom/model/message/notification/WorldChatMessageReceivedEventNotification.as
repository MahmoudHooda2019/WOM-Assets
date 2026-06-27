package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class WorldChatMessageReceivedEventNotification extends AbstractIncomingMessage
   {
      
      private var _senderPid:Number;
      
      private var _chatMessage:String;
      
      private var _senderName:String;
      
      private var _isAdmin:Boolean;
      
      public function WorldChatMessageReceivedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _senderPid = param1["senderPid"];
         _chatMessage = param1["message"];
         _senderName = param1["senderName"];
         _isAdmin = param1["isAdmin"];
      }
      
      public function get chatMessage() : String
      {
         return _chatMessage;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get isAdmin() : Boolean
      {
         return _isAdmin;
      }
      
      public function get senderPid() : Number
      {
         return _senderPid;
      }
   }
}

