package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BuyItemRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _itemId:int;
      
      private var _instanceId:int;
      
      private var _cost:int;
      
      public function BuyItemRequest(param1:int, param2:int = -1, param3:int = -1)
      {
         super();
         _itemId = param1;
         _instanceId = param2;
         _cost = param3;
      }
      
      override public function serialize() : Object
      {
         if(_instanceId != -1)
         {
            if(_cost != -1)
            {
               return {
                  "instanceId":_instanceId,
                  "itemId":_itemId,
                  "cost":_cost
               };
            }
            return {
               "instanceId":_instanceId,
               "itemId":_itemId
            };
         }
         return {"itemId":_itemId};
      }
   }
}

