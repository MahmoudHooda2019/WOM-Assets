package wom.model.message.response.guest
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class SetAvatarResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _name:String;
      
      private var _avatarId:int;
      
      public function SetAvatarResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         _name = param1.avatarName;
         _avatarId = param1.avatarId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
   }
}

