package peak.messaging.json
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.messaging.*;
   import peak.serialization.json.PJSON;
   
   public class JsonStringToMessageContainerConverterUsingIncomingMessageMap implements DataToMessageContainerConverter
   {
      
      [Inject]
      public var messageMap:IncomingMessageMap;
      
      public function JsonStringToMessageContainerConverterUsingIncomingMessageMap()
      {
         super();
      }
      
      public function convert(param1:*) : IncomingMessageContainer
      {
         var _loc3_:Class = null;
         var _loc2_:IncomingMessage = null;
         var _loc9_:* = param1.toString();
         var _loc8_:Object = JSON.parse(_loc9_);
         var _loc6_:* = _loc8_.t;
         var _loc5_:int = int(_loc8_.m);
         var _loc4_:Object = _loc8_.c;
         var _loc7_:IncomingMessageContainer = null;
         if(messageMap.hasClassForType(_loc6_))
         {
            _loc3_ = messageMap.getClassByType(_loc6_);
            _loc2_ = new _loc3_();
            _loc2_.deserialize(_loc4_);
            _loc7_ = new DefaultIncomingMessageContainer(_loc6_,_loc5_,_loc2_);
         }
         else
         {
            log(LoggerContexts.NETWORK,"Message map does not contain class for message type: " + _loc6_);
         }
         return _loc7_;
      }
   }
}

