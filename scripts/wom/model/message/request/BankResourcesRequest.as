package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BankResourcesRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _instanceId:int;
      
      public function BankResourcesRequest(param1:int)
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

