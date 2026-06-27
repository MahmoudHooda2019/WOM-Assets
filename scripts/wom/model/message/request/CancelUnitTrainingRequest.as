package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class CancelUnitTrainingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _instanceId:int;
      
      public function CancelUnitTrainingRequest(param1:int)
      {
         super();
         _instanceId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"instanceId":_instanceId};
      }
   }
}

