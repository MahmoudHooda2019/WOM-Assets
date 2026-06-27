package peak.messaging
{
   public interface IncomingMessage extends Message
   {
      
      function deserialize(param1:Object) : void;
   }
}

