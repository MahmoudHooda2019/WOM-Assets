package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class RearmTrapsResponse extends AbstractIncomingMessage
   {
      
      private var _success:Boolean;
      
      private var _resultMessage:String;
      
      private var _resultCode:int;
      
      public function RearmTrapsResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _success = param1.resultCode == 0;
         _resultMessage = param1.resultMessage;
         _resultCode = param1.resultCode;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
   }
}

