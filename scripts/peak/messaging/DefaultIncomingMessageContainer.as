package peak.messaging
{
   public class DefaultIncomingMessageContainer extends AbstractMessageContainer implements IncomingMessageContainer
   {
      
      protected var _message:IncomingMessage;
      
      public function DefaultIncomingMessageContainer(param1:*, param2:int, param3:IncomingMessage)
      {
         _message = param3;
         super(param1,param2);
      }
      
      public function get message() : IncomingMessage
      {
         return _message;
      }
   }
}

