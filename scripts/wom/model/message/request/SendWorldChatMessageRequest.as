package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class SendWorldChatMessageRequest extends AbstractOutgoingMessage
   {
      
      private var _chatMessage:String;
      
      public function SendWorldChatMessageRequest(param1:String)
      {
         super();
         _chatMessage = param1;
      }
      
      override public function serialize() : Object
      {
         return {"message":_chatMessage};
      }
   }
}

