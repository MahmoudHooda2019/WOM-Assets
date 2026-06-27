package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ForwardNPCAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _durationInSecs:int;
      
      public function ForwardNPCAttackRequest(param1:int)
      {
         super();
         _durationInSecs = param1;
      }
      
      override public function serialize() : Object
      {
         return {"durationInSecs":_durationInSecs};
      }
   }
}

