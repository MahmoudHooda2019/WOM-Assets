package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ThawBeastRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _beastId:int;
      
      public function ThawBeastRequest(param1:int)
      {
         super();
         _beastId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"beastId":_beastId};
      }
   }
}

