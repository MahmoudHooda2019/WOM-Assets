package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class UseEventItemRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _itemId:int;
      
      public function UseEventItemRequest(param1:int)
      {
         super();
         _itemId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"itemId":_itemId};
      }
   }
}

