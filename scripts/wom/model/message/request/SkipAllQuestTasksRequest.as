package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SkipAllQuestTasksRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _questId:int;
      
      public function SkipAllQuestTasksRequest(param1:int)
      {
         super();
         _questId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"questId":_questId};
      }
   }
}

