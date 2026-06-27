package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class RechargeCatapultResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _catapultId:int;
      
      public function RechargeCatapultResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         _catapultId = param1.catapultId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get catapultId() : int
      {
         return _catapultId;
      }
   }
}

