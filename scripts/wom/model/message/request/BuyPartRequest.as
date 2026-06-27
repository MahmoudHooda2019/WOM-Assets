package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BuyPartRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _partId:int;
      
      private var _amount:int;
      
      private var _byRp:Boolean;
      
      public function BuyPartRequest(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         _partId = param1;
         _amount = param2;
         _byRp = param3;
      }
      
      override public function serialize() : Object
      {
         if(_byRp)
         {
            return {
               "amount":_amount,
               "partId":_partId,
               "byRP":_byRp
            };
         }
         return {
            "amount":_amount,
            "partId":_partId
         };
      }
   }
}

