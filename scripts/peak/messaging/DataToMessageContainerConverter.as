package peak.messaging
{
   public interface DataToMessageContainerConverter
   {
      
      function convert(param1:*) : IncomingMessageContainer;
   }
}

