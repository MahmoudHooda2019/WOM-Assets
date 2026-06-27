package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BuyUnitRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _unitTypeId:int;
      
      public function BuyUnitRequest(param1:int)
      {
         super();
         _unitTypeId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"unitAmounts":[{
            "id":_unitTypeId,
            "amount":1
         }]};
      }
   }
}

