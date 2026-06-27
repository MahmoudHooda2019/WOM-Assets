package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class GoldBankedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingTime:Number;
      
      private var _bankedGold:int;
      
      public function GoldBankedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingTime = param1.remainingTime;
         _bankedGold = param1.bankedGold;
      }
      
      public function get remainingTime() : Number
      {
         return _remainingTime;
      }
      
      public function get bankedGold() : int
      {
         return _bankedGold;
      }
   }
}

