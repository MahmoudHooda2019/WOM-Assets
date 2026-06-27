package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class TrainBeastRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _byGold:Boolean;
      
      public function TrainBeastRequest(param1:Boolean = false)
      {
         super();
         _byGold = param1;
      }
      
      override public function serialize() : Object
      {
         return {"byGold":_byGold};
      }
   }
}

