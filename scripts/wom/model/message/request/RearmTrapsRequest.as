package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RearmTrapsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _byGold:Boolean;
      
      public function RearmTrapsRequest(param1:Boolean = false)
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

