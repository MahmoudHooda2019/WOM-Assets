package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class CancelConstructionResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      public function CancelConstructionResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
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

