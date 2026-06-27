package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class HireWorkerRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _byGold:Boolean;
      
      public function HireWorkerRequest(param1:Boolean = false)
      {
         super();
         _byGold = param1;
      }
      
      override public function serialize() : Object
      {
         if(_byGold)
         {
            return {"byGold":_byGold};
         }
         return {};
      }
   }
}

