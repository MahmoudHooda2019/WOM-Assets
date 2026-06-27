package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class FinishEventItemBuildRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _queueIndex:int;
      
      public function FinishEventItemBuildRequest(param1:int)
      {
         super();
         _queueIndex = param1;
      }
      
      override public function serialize() : Object
      {
         return {"queueIndex":_queueIndex};
      }
   }
}

