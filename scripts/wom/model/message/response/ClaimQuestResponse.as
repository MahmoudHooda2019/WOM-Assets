package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ClaimQuestResponse extends AbstractIncomingMessage
   {
      
      private var _result:Boolean;
      
      private var _questId:int;
      
      public function ClaimQuestResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _result = param1.result;
         _questId = param1.questId;
      }
      
      public function get result() : Boolean
      {
         return _result;
      }
      
      public function get questId() : int
      {
         return _questId;
      }
   }
}

