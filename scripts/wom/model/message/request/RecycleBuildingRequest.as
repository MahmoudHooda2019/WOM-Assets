package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RecycleBuildingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _instanceId:int;
      
      public function RecycleBuildingRequest(param1:int)
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

