package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class IdleWorkerRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _m:String;
      
      private var _d:Boolean;
      
      public function IdleWorkerRequest(param1:String, param2:Boolean = true)
      {
         super();
         _m = param1;
         _d = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "m":_m,
            "d":_d
         };
      }
   }
}

