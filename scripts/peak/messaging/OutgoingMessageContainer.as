package peak.messaging
{
   public interface OutgoingMessageContainer extends MessageContainer
   {
      
      function get message() : OutgoingMessage;
   }
}

