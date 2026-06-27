package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.inventory.ResourceQuantityType;
   
   public class UseResourceGiftRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _giftId:int;
      
      private var _resourceQuantityType:ResourceQuantityType;
      
      private var _amount:int;
      
      public function UseResourceGiftRequest(param1:int, param2:ResourceQuantityType, param3:int)
      {
         super();
         _giftId = param1;
         _resourceQuantityType = param2;
         _amount = param3;
      }
      
      override public function serialize() : Object
      {
         return {
            "amount":_amount,
            "resourceGiftAmountType":_resourceQuantityType.id,
            "giftId":_giftId
         };
      }
   }
}

