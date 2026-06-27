package peak.messaging
{
   public interface IncomingMessageMap
   {
      
      function mapMessage(param1:*, param2:Class) : void;
      
      function unmapMessage(param1:*) : void;
      
      function unmapAll() : void;
      
      function getClassByType(param1:*) : Class;
      
      function hasClassForType(param1:*) : Boolean;
      
      function getEventTypeFor(param1:Class) : String;
   }
}

