package peak.messaging
{
   public interface IncomingMessageContainer extends MessageContainer
   {
      
      function get message() : IncomingMessage;
   }
}

