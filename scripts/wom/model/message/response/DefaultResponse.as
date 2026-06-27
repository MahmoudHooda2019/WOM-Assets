package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class DefaultResponse extends AbstractIncomingMessage
   {
      
      protected var _resultCode:int;
      
      protected var _resultMessage:String;
      
      public function DefaultResponse()
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

