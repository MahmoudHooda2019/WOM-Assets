package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class CancelAllianceInvitationResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _userId:Number;
      
      public function CancelAllianceInvitationResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _userId = param1.userId;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get userId() : Number
      {
         return _userId;
      }
   }
}

