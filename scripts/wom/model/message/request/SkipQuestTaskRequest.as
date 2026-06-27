package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SkipQuestTaskRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _taskId:int;
      
      public function SkipQuestTaskRequest(param1:int)
      {
         super();
         _taskId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"taskId":_taskId};
      }
   }
}

