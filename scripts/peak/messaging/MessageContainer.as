package peak.messaging
{
   public interface MessageContainer
   {
      
      function get messageType() : *;
      
      function get messageId() : int;
   }
}

