package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BeastCannonAmmoAmountChanedEventNotification extends AbstractIncomingMessage
   {
      
      private var _ammoAmount:int;
      
      private var _remainingDurationToFullAmmo:Number;
      
      public function BeastCannonAmmoAmountChanedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _ammoAmount = param1.ammoAmount;
         _remainingDurationToFullAmmo = param1.remainingDurationToFullAmmo;
      }
      
      public function get ammoAmount() : int
      {
         return _ammoAmount;
      }
      
      public function get remainingDurationToFullAmmo() : Number
      {
         return _remainingDurationToFullAmmo;
      }
   }
}

