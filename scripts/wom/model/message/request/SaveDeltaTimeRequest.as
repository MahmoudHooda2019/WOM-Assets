package wom.model.message.request
{
   import flash.utils.ByteArray;
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import peak.util.Base64;
   
   public class SaveDeltaTimeRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _deltaTimePool:ByteArray;
      
      private var _index:int;
      
      public function SaveDeltaTimeRequest(param1:int, param2:ByteArray)
      {
         super();
         _deltaTimePool = param2;
         _index = param1;
      }
      
      override public function serialize() : Object
      {
         return {
            "i":_index,
            "dt":Base64.encodeByteArray(_deltaTimePool)
         };
      }
   }
}

