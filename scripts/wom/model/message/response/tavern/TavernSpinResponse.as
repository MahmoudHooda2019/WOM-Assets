package wom.model.message.response.tavern
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class TavernSpinResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _spinGiftId:int;
      
      private var _unlockedCardIndex:int = -1;
      
      private var _tillNextSpin:Number;
      
      public function TavernSpinResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _spinGiftId = param1.spinGiftId;
            if("unlockedCardIndex" in param1 && param1.unlockedCardIndex != null)
            {
               _unlockedCardIndex = param1.unlockedCardIndex;
            }
            _tillNextSpin = param1.tillNextSpin;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get spinGiftId() : int
      {
         return _spinGiftId;
      }
      
      public function get unlockedCardIndex() : int
      {
         return _unlockedCardIndex;
      }
      
      public function get tillNextSpin() : Number
      {
         return _tillNextSpin;
      }
   }
}

