package peak.messaging
{
   public interface OutgoingMessageMap
   {
      
      function mapMessage(param1:*, param2:Class) : void;
      
      function unmapMessage(param1:Class) : void;
      
      function unmapAll() : void;
      
      function getTypeByClass(param1:Class) : *;
      
      function getTypeByInstance(param1:Message) : *;
   }
}

