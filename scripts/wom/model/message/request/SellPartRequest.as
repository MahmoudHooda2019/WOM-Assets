package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SellPartRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _partId:int;
      
      private var _amount:int;
      
      public function SellPartRequest(param1:int, param2:int)
      {
         super();
         _partId = param1;
         _amount = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "amount":_amount,
            "partId":_partId
         };
      }
   }
}

