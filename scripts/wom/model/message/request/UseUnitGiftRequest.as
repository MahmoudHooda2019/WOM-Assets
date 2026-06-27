package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class UseUnitGiftRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _id:int;
      
      private var _unitAmount:int;
      
      private var _amount:int;
      
      public function UseUnitGiftRequest(param1:int, param2:int, param3:int)
      {
         super();
         _id = param1;
         _unitAmount = param2;
         _amount = param3;
      }
      
      override public function serialize() : Object
      {
         return {
            "id":_id,
            "unitAmount":_unitAmount,
            "amount":_amount
         };
      }
   }
}

