package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class HelpFriendResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _helpedGameUid:String;
      
      private var _instanceId:int;
      
      public function HelpFriendResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(!_resultCode)
         {
            _helpedGameUid = "helpedGameUid" in param1 && param1.helpedGameUid != null ? param1.helpedGameUid : param1.helpedNpcName;
            _instanceId = param1.instanceId;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get helpedGameUid() : String
      {
         return _helpedGameUid;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

