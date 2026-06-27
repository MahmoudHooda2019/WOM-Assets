package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UseUnitGiftResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      public function UseUnitGiftResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.result;
         _resultMessage = param1.resultMessage;
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

