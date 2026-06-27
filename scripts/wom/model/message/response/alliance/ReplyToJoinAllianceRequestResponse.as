package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ReplyToJoinAllianceRequestResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _requestingUserId:Number;
      
      private var _accepted:Boolean;
      
      public function ReplyToJoinAllianceRequestResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _accepted = param1.accepted;
         }
         _requestingUserId = param1.requestingUserId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get requestingUserId() : Number
      {
         return _requestingUserId;
      }
      
      public function get accepted() : Boolean
      {
         return _accepted;
      }
   }
}

