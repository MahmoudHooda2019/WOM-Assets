package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class CancelEventItemBuildRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _queueIndex:int;
      
      public function CancelEventItemBuildRequest(param1:int)
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

