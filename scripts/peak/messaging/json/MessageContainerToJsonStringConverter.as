package peak.messaging.json
{
   import peak.messaging.MessageContainerToDataConverter;
   import peak.messaging.OutgoingMessageContainer;
   import peak.serialization.json.PJSON;
   
   public class MessageContainerToJsonStringConverter implements MessageContainerToDataConverter
   {
      
      public function MessageContainerToJsonStringConverter()
      {
         super();
      }
      
      public function convert(param1:OutgoingMessageContainer) : *
      {
         var _loc2_:Object = {
            "t":param1.messageType,
            "m":param1.messageId,
            "c":param1.message.serialize()
         };
         return PJSON.encode(_loc2_);
      }
   }
}

