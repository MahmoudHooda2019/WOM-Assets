package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class CancelActiveHiringRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _instanceId:int;
      
      private var _validate:Boolean;
      
      public function CancelActiveHiringRequest(param1:int, param2:Boolean)
      {
         super();
         _instanceId = param1;
         _validate = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "instanceId":_instanceId,
            "validate":_validate
         };
      }
   }
}

