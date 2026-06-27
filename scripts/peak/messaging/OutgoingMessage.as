package peak.messaging
{
   public interface OutgoingMessage extends Message
   {
      
      function serialize() : Object;
   }
}

