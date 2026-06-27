package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class EndNPCAttackResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _npcName:String;
      
      public function EndNPCAttackResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         _npcName = param1.npcName;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get npcName() : String
      {
         return _npcName;
      }
   }
}

