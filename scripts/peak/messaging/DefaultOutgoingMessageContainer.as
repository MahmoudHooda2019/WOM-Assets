package peak.messaging
{
   public class DefaultOutgoingMessageContainer extends AbstractMessageContainer implements OutgoingMessageContainer
   {
      
      protected var _message:OutgoingMessage;
      
      public function DefaultOutgoingMessageContainer(param1:*, param2:int, param3:OutgoingMessage)
      {
         _message = param3;
         super(param1,param2);
      }
      
      public function get message() : OutgoingMessage
      {
         return _message;
      }
   }
}

