package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UpdateUserTutorialResponse extends AbstractIncomingMessage
   {
      
      private var _success:Boolean;
      
      private var _errorType:int;
      
      private var _resultMessage:String;
      
      public function UpdateUserTutorialResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _success = param1.resultCode == 0;
         if(!_success)
         {
            _errorType = param1.resultCode;
         }
         else
         {
            _errorType = -1;
         }
         _resultMessage = param1.resultMessage;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get errorType() : int
      {
         return _errorType;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
   }
}

