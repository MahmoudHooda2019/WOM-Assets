package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RemoveQueuedHiresRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var instanceId:int;
      
      private var slot:int;
      
      private var amount:int;
      
      private var validate:Boolean;
      
      public function RemoveQueuedHiresRequest(param1:int, param2:int, param3:int, param4:Boolean)
      {
         super();
         this.instanceId = param1;
         this.slot = param2;
         this.amount = param3;
         this.validate = param4;
      }
      
      override public function serialize() : Object
      {
         return {
            "instanceId":instanceId,
            "slot":slot,
            "amount":amount,
            "validate":validate
         };
      }
   }
}

